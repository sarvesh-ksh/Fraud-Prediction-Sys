from dotenv import load_dotenv
import os
import pandas as pd
import snowflake.connector
from datetime import datetime

load_dotenv()

def load_data(sample,sample_size=100000) -> pd.DataFrame:
    with  snowflake.connector.connect(
        account = os.getenv("SNOWFLAKE_ACCOUNT"),
        user= os.getenv("SNOWFLAKE_USER"),
        password= os.getenv("SNOWFLAKE_PASSWORD"),
        warehouse= os.getenv("SNOWFLAKE_WAREHOUSE"),
        database= os.getenv("SNOWFLAKE_DATABASE"),
        schema= os.getenv("SNOWFLAKE_SCHEMA"),
        role= os.getenv("SNOWFLAKE_ROLE")
    ) as conn:
        if sample:
            query = f"""
            select 
                * 
            from 
                ML_FEATURES 
            limit {sample_size}
            """
        else:
            query = """
            select 
                * 
            from    
                ML_FEATURES
            """
            
        with conn.cursor() as cursor:
            cursor.execute(query)
            df = cursor.fetch_pandas_all()
            
    return df
    
if __name__ == "__main__":
    start = datetime.now()
    df = load_data(sample=False)
    end = datetime.now()
    print("time taken :",end - start)
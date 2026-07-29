import os

import pandas as pd
import snowflake.connector
from dotenv import load_dotenv
from joblib import load
from snowflake.connector.pandas_tools import write_pandas

from data_loader import load_data
from preprocess import preprocessed_data

load_dotenv()

MODEL_VERSION = "rf_v1"


def upload_predictions(prediction_df: pd.DataFrame) -> None:
    """
    Upload prediction DataFrame to Snowflake using write_pandas().
    """

    with snowflake.connector.connect(
        account=os.getenv("SNOWFLAKE_ACCOUNT"),
        user=os.getenv("SNOWFLAKE_USER"),
        password=os.getenv("SNOWFLAKE_PASSWORD"),
        warehouse=os.getenv("SNOWFLAKE_WAREHOUSE"),
        database=os.getenv("SNOWFLAKE_DATABASE"),
        schema="GOLD",
        role=os.getenv("SNOWFLAKE_ROLE"),
    ) as conn:

        success, nchunks, nrows, _ = write_pandas(
            conn=conn,
            df=prediction_df,
            table_name="FRAUD_PREDICTIONS",
            schema="GOLD",
            auto_create_table=False,
            overwrite=False,
        )

    if success:
        print(f"Successfully uploaded {nrows} rows in {nchunks} chunk(s).")
    else:
        print("Upload failed.")


def predict() -> pd.DataFrame:
    """
    Generate fraud predictions.
    """

    model = load("models/random_forest_baseline.pkl")

    df = load_data(sample=False)

    X, _ = preprocessed_data(df)

    predictions = model.predict(X)
    probabilities = model.predict_proba(X)[:, 1]

    prediction_df = pd.DataFrame(
        {
            "TRANSACTION_KEY": df["TRANSACTION_KEY"],
            "STEP" : df["STEP"],
            "PREDICTED_FRAUD": predictions.astype(bool),
            "ACTUAL_FRAUD": df["IS_FRAUD"].astype(bool),
            "FRAUD_PROBABILITY": probabilities,
            "MODEL_VERSION": MODEL_VERSION,
        }
    )

    return prediction_df


if __name__ == "__main__":

    prediction_df = predict()

    print(prediction_df.head())

    upload_predictions(prediction_df)
import pandas as pd
from data_loader import load_data

# get col is_fraud for preprocess
def preprocessed_data(df):
    y = df["IS_FRAUD"]

    # drop the cols that irrelevant for preprocess
    x = df.drop(
        columns=[
            "TRANSACTION_KEY",
            "IS_FRAUD",
            "SENDER_ACCOUNT",
            "RECEIVER_ACCOUNT"
        ]
    )

    # change the dtype of categorical col for preprocess
    x = pd.get_dummies(
        x,
        columns=["PAYMENT_TYPE"],
        dtype = int   
    )

    """
    converting the OVERALL_ACTIVITY_COUNT col type cause  the snowfalke returns number column as 
    decimal.Decimal, so pandas report them as obj
    """
    x["OVERALL_ACTIVITY_COUNT"] = x["OVERALL_ACTIVITY_COUNT"].astype("int64")
    
    return x,y

if __name__ == "__main__":
    df=load_data(sample=False)
    x,y = preprocessed_data(df)
    print("\n\t\t=========================== processed data info ===========================\n")
    print(x.dtypes)
    print(x.shape)
    print(y.shape)
    print(x.isnull().sum())
PaySim Dataset (raw dataset from kaggle to train and test model)
        │
        ▼
AWS S3 (toring the raw dataset and other files)
        │
        ▼
Snowflake RAW Layer (The RAW (Bronze) layer stores the data exactly as received from S3)
        │
        ▼
dbt Transformations (to perform the transformation on our dataset we're usig DBT)
        │
        ▼
Snowflake SILVER Layer (The Silver layer is where data engineering transformations happen)
        │
        ▼
dbt Business Transformations (this is the layer we'er we implementing the business logic on silver layer)
        │
        ▼
Snowflake GOLD Layer (The Gold layer contains business-ready, trusted datasets.)
        │
        ▼
Python Feature Engineering (model traning part)
        │
        ▼
Machine Learning Model (building the model)
        │
        ▼
Fraud Predictions (testing the model)
        │
        ▼
Power BI Dashboard (visualizing the outcoms of the model )
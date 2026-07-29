# 💳 Financial Fraud Detection & Prediction System

An end-to-end production-style Financial Fraud Detection & Prediction System built using modern Data Engineering, Cloud, and Machine Learning technologies.

The project demonstrates how financial transaction data can be ingested, transformed, engineered, used to train a machine learning model, and written back to a cloud data warehouse for downstream analytics.

---

# 📌 Project Architecture

```
                GitHub
                   │
                   ▼
            AWS S3 Data Lake
                   │
                   ▼
          Snowflake (RAW Layer)
                   │
                   ▼
       dbt Transformations (SILVER)
                   │
                   ▼
        dbt Business Models (GOLD)
                   │
                   ▼
        Python Feature Engineering
                   │
                   ▼
      Machine Learning Pipeline
                   │
                   ▼
      Fraud Predictions Generation
                   │
                   ▼
    Snowflake Prediction Table
```

---

# 🚀 Tech Stack

## Cloud

- AWS S3
- Snowflake

## Data Engineering

- dbt Core
- SQL
- Python
- Pandas
- NumPy

## Machine Learning

- Scikit-learn
- Random Forest Classifier
- Joblib

## Development

- Git
- GitHub
- VS Code

---

# 📂 Project Structure

```
Fraud-Prediction-Sys
│
├── dbt/
│   ├── models/
│   │   ├── silver/
│   │   ├── gold/
│   │   └── analysis/
│   ├── macros/
│   └── tests/
│
├── python/
│   ├── data_loader.py
│   ├── preprocess.py
│   ├── train.py
│   ├── evaluate.py
│   ├── predict.py
│   └── models/
│
├── docs/
│
├── requirements.txt
│
└── README.md
```

---

# 🏗 Data Warehouse Architecture

The project follows the Medallion Architecture.

## RAW Layer

Stores the original PaySim dataset without modifications.

---

## SILVER Layer

Responsible for data cleaning and transformation.

Tasks performed:

- Data type standardization
- Column renaming
- Data quality checks
- dbt tests
- Clean staging model

---

## GOLD Layer

Contains business-ready analytical models.

### Fact Table

**FCT_TRANSACTIONS**

Stores transaction-level information.

Includes:

- Transaction Key
- Payment Type
- Amount
- Sender Account
- Receiver Account
- Account Balances
- Fraud Labels

---

### Dimension Table

**DIM_ACCOUNTS**

Contains account-level aggregated information.

Includes:

- Account ID
- Account Type
- Total Sent Amount
- Total Received Amount

---

### ML Feature Table

**ML_FEATURES**

Contains engineered features used only for Machine Learning.

Engineered Features:

- Sender Balance Change
- Receiver Balance Change
- Balance Change Ratio
- Large Transaction Flag
- Sender Activity Count
- Receiver Activity Count
- Overall Activity Count
- Sender Balance Unchanged Flag

---

# 🤖 Machine Learning Pipeline

Pipeline Steps

1. Load data from Snowflake
2. Preprocess data
3. Feature Encoding
4. Train Random Forest Classifier
5. Evaluate Model
6. Save Trained Model
7. Predict Fraud
8. Upload Predictions to Snowflake

---

# 📊 Model Performance

| Metric | Score |
|---------|-------|
| Recall (Fraud) | **0.91** |
| ROC-AUC Score | **0.977** |

The model is optimized to maximize fraud detection while maintaining strong overall classification performance.

---

# 📁 Python Modules

## data_loader.py

- Connects to Snowflake
- Loads GOLD layer data
- Uses `fetch_pandas_all()`

---

## preprocess.py

- Splits features and labels
- One-hot encodes categorical columns
- Removes unnecessary columns
- Returns processed dataset

---

## train.py

- Splits training/testing datasets
- Trains Random Forest model
- Saves trained model using Joblib

---

## evaluate.py

Evaluates model using:

- Confusion Matrix
- Classification Report
- ROC-AUC Score

---

## predict.py

- Loads trained model
- Predicts fraud probability
- Uploads predictions to Snowflake using `write_pandas()`

---

# 📦 Snowflake Objects

Schemas

```
RAW
SILVER
GOLD
```

Tables

```
RAW.PAYSIM

SILVER.STG_PAYSIM

GOLD.FCT_TRANSACTIONS

GOLD.DIM_ACCOUNTS

GOLD.ML_FEATURES

GOLD.FRAUD_PREDICTIONS
```

---

# 🔑 Key Features

- End-to-End Data Engineering Pipeline
- Cloud Data Lake using AWS S3
- Snowflake Data Warehouse
- dbt Transformations
- Feature Engineering
- Machine Learning Pipeline
- Automated Prediction Upload
- Production-style Project Structure
- Modular Python Codebase

---

# ⚙️ Setup

## Clone Repository

```bash
git clone https://github.com/sarvesh-ksh/Fraud-Prediction-Sys.git
```

---

## Install Dependencies

```bash
pip install -r requirements.txt
```

---

## Configure Environment

Create a `.env` file with your Snowflake credentials.

Example:

```
SNOWFLAKE_USER=
SNOWFLAKE_PASSWORD=
SNOWFLAKE_ACCOUNT=
SNOWFLAKE_WAREHOUSE=
SNOWFLAKE_DATABASE=
SNOWFLAKE_SCHEMA=
```

---

## Run Training

```bash
python python/train.py
```

---

## Run Evaluation

```bash
python python/evaluate.py
```

---

## Generate Predictions

```bash
python python/predict.py
```

---

# 🔮 Future Improvements

- Interactive Power BI Dashboard
- Docker Containerization
- Apache Airflow Pipeline Orchestration
- MLflow Experiment Tracking
- Model Monitoring
- CI/CD using GitHub Actions
- Real-time Fraud Detection API using FastAPI
- PySpark-based Distributed Processing

---

# 📚 Dataset

**PaySim Financial Transactions Dataset**

A synthetic mobile money transaction dataset widely used for fraud detection research.

---

# 👨‍💻 Author

**Sarvesh Kshatriya**

- GitHub: https://github.com/sarvesh-ksh
- LinkedIn: https://www.linkedin.com/in/sarvesh-kshatriya/

---

## ⭐ If you found this project useful, consider giving it a star.

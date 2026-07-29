from sklearn.metrics import (
    confusion_matrix,
    classification_report,
    roc_auc_score
)
from train import train_model
import joblib
def evaluate_model():
    model = joblib.load("models/random_forest_baseline.pkl")
    x_test, y_test = train_model()

    y_pred = model.predict(x_test)
    y_prob = model.predict_proba(x_test)[:, 1]

    metrics = {
        "confusion_matrix": confusion_matrix(y_test, y_pred),
        "classification_report": classification_report(y_test, y_pred),
        "roc_auc": roc_auc_score(y_test, y_prob)
    }

    return metrics


if __name__ == "__main__":

    results = evaluate_model()

    print("\n========== Confusion Matrix ==========\n")
    print(results["confusion_matrix"])

    print("\n========== Classification Report ==========\n")
    print(results["classification_report"])

    print("\n========== ROC-AUC Score ==========\n")
    print(f"{results['roc_auc']:.4f}")
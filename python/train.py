from preprocess import preprocessed_data
from data_loader import load_data
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
import joblib
def train_model():
    df=load_data(sample=False)
    x,y = preprocessed_data(df)
    x_train, x_test, y_train, y_test = train_test_split(
        x,
        y,
        test_size=0.2,
        random_state=42,
        stratify=y
    )
    
    model = RandomForestClassifier(
        n_estimators=100,
        random_state=42,
        n_jobs=-1,
        class_weight="balanced"
    )
    
    model.fit(x_train,y_train)
    save_model(model)
    return x_test,y_test

def save_model(model):
    joblib.dump(model,"models/random_forest_baseline.pkl")
    
if __name__ == "__main__":
    train_model()
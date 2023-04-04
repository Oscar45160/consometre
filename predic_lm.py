import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error
from sklearn.impute import SimpleImputer

# Charger les données (remplacez par le nom de votre fichier CSV)
data = pd.read_csv("donnees.csv")

# Sélectionner les variables pertinentes
X = data[["Température (°C)", "Point de rosée", "datehour", "datemonth"]]
y = data["consommation"]

# Diviser les données en ensembles d'entraînement et de test
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Créer un imputer pour remplacer les valeurs manquantes (NaN) par la moyenne des colonnes
imputer = SimpleImputer(strategy="mean")

# Ajuster l'imputer sur X_train et transformer X_train et X_test
X_train = imputer.fit_transform(X_train)
X_test = imputer.transform(X_test)

# Créer et entraîner le modèle de régression linéaire multiple
model = LinearRegression()
model.fit(X_train, y_train)

# Prédire la consommation électrique sur l'ensemble de test
y_pred = model.predict(X_test)

# Calculer l'erreur quadratique moyenne (RMSE) pour évaluer la performance du modèle
rmse = np.sqrt(mean_squared_error(y_test, y_pred))
print("RMSE:", rmse)

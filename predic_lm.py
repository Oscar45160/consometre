# Importation des librairies
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error

# Importation des données

data = pd.read_csv("votre_fichier_de_donnees.csv")


# Création des variables explicatives et de la variable à expliquer
X = data[['Température', 'Humidité', 'Vitesse du vent moyen 10 mn', 'hour', 'month']]
y = data['consommation']


# Création des données d'entrainement et de test
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)


# Normalisation des données
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)


# Entrainer le modèle
model = RandomForestRegressor(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# Evaluer le modèle
y_pred = model.predict(X_test)
rmse = np.sqrt(mean_squared_error(y_test, y_pred))
print("RMSE: ", rmse)

# Prédire la consommation
# Assurez-vous que les données météorologiques prévues sont dans le même format que les données d'entraînement
predicted_weather_data = np.array([[température, humidité, vitesse_du_vent, heure, mois]])
predicted_weather_data = scaler.transform(predicted_weather_data)  # Normalisez les données si nécessaire
predicted_consumption = model.predict(predicted_weather_data)
print("Consommation prévue pour le prochain jour : ", predicted_consumption)


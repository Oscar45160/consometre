# Importation des librairies
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error

# Importation des données
data = pd.read_csv("donnees.csv",)

# Suppression des données manquantes
data = data.dropna()  # Supprime les lignes avec des données manquantes
data['Date_Heure'] = pd.to_datetime(data['Date_Heure'])

# print DataFrame
print(data)


# Création des variables explicatives et de la variable à expliquer
X = data[['Vitesse du vent moyen 10 mn', 'Humidité', 'Précipitations dans les 3 dernières heures', 'Température (°C)']]
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

# Définissez vos valeurs de données météorologiques prévues
temperature = 20  # Remplacez 20 par la température prévue
humidite = 50  # Remplacez 50 par l'humidité prévue
vitesse_du_vent = 10  # Remplacez 10 par la vitesse du vent prévue
precipitations = 0  # Remplacez 0 par les précipitations prévues dans les 3 dernières heures

# Prédire la consommation
predicted_weather_data = np.array([[vitesse_du_vent, humidite, precipitations, temperature]])
predicted_weather_data = scaler.transform(predicted_weather_data)  # Normalisez les données si nécessaire
predicted_consumption = model.predict(predicted_weather_data)
print("Consommation prévue pour le prochain jour : ", predicted_consumption)

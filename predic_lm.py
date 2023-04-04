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

from statsmodels.tsa.arima.model import ARIMA

# Charger les données historiques (remplacez par le nom de votre fichier CSV)
weather_data = pd.read_csv("donnees.csv")

# Convertir la colonne de date en un objet datetime
weather_data["datehour"] = pd.to_datetime(weather_data["datehour"])

# Supprimer les doublons
weather_data = weather_data.groupby("datehour").agg({"consommation": "sum", "Température (°C)": "mean", "Point de rosée": "mean"}).reset_index()

# Régler la fréquence de l'index de date (ajustez 'H' en fonction de la fréquence de vos données)
weather_data = weather_data.set_index("datehour").asfreq('D')

# Sélectionner les variables pertinentes
temperature = weather_data[["Température (°C)"]]
dew_point = weather_data[["Point de rosée"]]

# Créer et ajuster les modèles ARIMA
temperature_model = ARIMA(temperature, order=(1, 1, 1)).fit()
dew_point_model = ARIMA(dew_point, order=(1, 1, 1)).fit()

# Prévoir les valeurs des variables pertinentes pour le jour suivant
temperature_forecast = temperature_model.forecast(steps=1)[0]
dew_point_forecast = dew_point_model.forecast(steps=1)[0]


temperature_next_day = temperature_forecast
dew_point_next_day = dew_point_forecast
datehour_next_day = 5
datemonth_next_day = 1

prediction = model.predict([[temperature_next_day, dew_point_next_day, datehour_next_day, datemonth_next_day]])
print("Consommation électrique prévue pour le jour suivant :", prediction[0])

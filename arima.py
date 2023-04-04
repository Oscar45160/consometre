import pandas as pd
from statsmodels.tsa.arima.model import ARIMA

# Charger les données historiques (remplacez par le nom de votre fichier CSV)
weather_data = pd.read_csv("donnees.csv")

# Convertir la colonne de date en un objet datetime
weather_data["datehour"] = pd.to_datetime(weather_data["datehour"])

# Supprimer les doublons
weather_data = weather_data.drop_duplicates(subset="datehour")

# Régler la fréquence de l'index de date (ajustez 'H' en fonction de la fréquence de vos données)
weather_data = weather_data.set_index("datehour").asfreq('H')

# Sélectionner les variables pertinentes
temperature = weather_data[["Température (°C)"]]
dew_point = weather_data[["Point de rosée"]]

# Créer et ajuster les modèles ARIMA
temperature_model = ARIMA(temperature, order=(1, 1, 1)).fit()
dew_point_model = ARIMA(dew_point, order=(1, 1, 1)).fit()

# Prévoir les valeurs des variables pertinentes pour le jour suivant
temperature_forecast = temperature_model.forecast(steps=1)[0]
dew_point_forecast = dew_point_model.forecast(steps=1)[0]

print("Température prévue pour le jour suivant:", temperature_forecast)
print("Point de rosée prévu pour le jour suivant:", dew_point_forecast)

import pandas as pd
import numpy as np
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt

# Charger les données
data = pd.read_csv('donnees.csv')

# Convertir la colonne 'Date_Heure' en datetime et extraire uniquement la date
data['Date_Heure'] = pd.to_datetime(data['Date_Heure'])
data['Date'] = data['Date_Heure'].dt.date

# Créer un DataFrame avec les colonnes 'Date' et 'Température (Â°C)'
temp_data = data[['Date', 'Température (°C)']].groupby('Date').mean().reset_index()

# Convertir la colonne 'Date' en nombre de jours depuis la date minimale
temp_data['Days'] = (temp_data['Date'] - temp_data['Date'].min()).dt.days

# Séparer les données en ensembles d'entraînement et de test
X = temp_data['Days'].values.reshape(-1, 1)
y = temp_data['Température (°C)']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=0)

# Entraîner le modèle de régression linéaire
regressor = LinearRegression()
regressor.fit(X_train, y_train)

# Faire une prévision pour les données de test
y_pred = regressor.predict(X_test)

# Visualiser les prévisions
plt.scatter(X_train, y_train, color='blue', label='Données d\'entraînement')
plt.scatter(X_test, y_test, color='green', label='Données de test')
plt.plot(X_test, y_pred, color='red', linestyle='--', label='Prédiction')
plt.xlabel('Jours depuis le début')
plt.ylabel('Température (Â°C)')
plt.legend()
plt.show()

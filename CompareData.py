import pandas as pd

# Lire les données Excel
df = pd.read_excel('donnees_meteo.xlsx', sheet_name='donnees meteo')
# Remplacer 'colonne1' et 'colonne2' par les noms des colonnes à comparer
x = df['Pression au niveau mer']
y = df['consommation']

if x.dtype != 'float64' and x.dtype != 'int64':
    raise TypeError('La colonne 1 ne contient pas de données numériques.')
if y.dtype != 'float64' and y.dtype != 'int64':
    raise TypeError('La colonne 2 ne contient pas de données numériques.')


# Calculer le coefficient de corrélation de Pearson
correlation = x.corr(y)

# Afficher la corrélation
print('Coefficient de corrélation de Pearson :', correlation)

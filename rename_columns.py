import pandas as pd


# Charger le fichier CSV dans un dataframe
df = pd.read_csv('donnees.csv')


# Utiliser la méthode rename pour changer le nom de la colonne
df = df.rename(columns={'Type de tendance barométrique': 'tendance_barometrique'})
df = df.rename(columns={'Température': 'Temperature'})
df = df.rename(columns={'Point de rosée': 'Point_de_rosee'})
df = df.rename(columns={'Humidité': 'Humidite'})
df = df.rename(columns={'Visibilité horizontale': 'Visibilite_horizontale'})
df = df.rename(columns={'Temps présent': 'Temps_present'})
df = df.rename(columns={'Rafales sur une période': 'Rafales_sur_une_periode'})
df = df.rename(columns={'Précipitations dans la dernière heure': 'Precipitations_derniere_heure'})
df = df.rename(columns={'Précipitations dans les 3 dernières heures': 'Precipitations_3_derniere_heures'})
df = df.rename(columns={'Température (°C)': 'Temperature_Celsius'})
df = df.rename(columns={'Pression au niveau mer': 'Pression_niveau_mere'})
df = df.rename(columns={'Variation de pression en 3 heures': 'Variation_3_heures'})
df = df.rename(columns={'Vitesse du vent moyen 10 mn': 'Vitesse_vent_moyen_10mn'})
df = df.rename(columns={'Periode de mesure de la rafale': 'Periode_mesure_rafale'})
df = df.rename(columns={'Pression station': 'Pression_station'})
df = df.rename(columns={'Direction du vent moyen 10 mn': 'Direction_vent_moyen_10mn'})
df = df.rename(columns={'index': 'casse_pied'})




df.to_csv('new_data.csv', index=False)



# Afficher le dataframe pour vérifier que la colonne a bien été renommée
print(df)

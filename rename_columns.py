import pandas as pd


# Charger le fichier CSV dans un dataframe
df = pd.read_csv('donnees.csv')


# Utiliser la méthode rename pour changer le nom de la colonne
df = df.rename(columns={'Type de tendance baromÃ©trique': 'Type de tendance barometrique'})
df = df.rename(columns={'TempÃ©rature': 'Temperature'})
df = df.rename(columns={'Point de rosÃ©e': 'Point de rose'})
df = df.rename(columns={'HumiditÃ©': 'Humidite'})
df = df.rename(columns={'VisibilitÃ© horizontale': 'Visibilite horizontale'})
df = df.rename(columns={'Temps prÃ©sent': 'Temps present'})
df = df.rename(columns={'Rafales sur une pÃ©riode': 'Rafales sur une periode'})
df = df.rename(columns={'PrÃ©cipitations dans la derniÃ¨re heure': 'Precipitations dans la derniere heure'})
df = df.rename(columns={'PrÃ©cipitations dans les 3 derniÃ¨res heures': 'Precipitations dans les 3 derniere heures'})
df = df.rename(columns={'Température (°C)': 'Temperature (°C)'})


df.to_csv('new_data.csv', index=False)



# Afficher le dataframe pour vérifier que la colonne a bien été renommée
print(df)

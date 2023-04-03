const RandomForestRegression = require('ml-regression-random-forest');
const preprocess = require('ml-preprocess');
const fs = require('fs');
const parse = require('csv-parse/lib/sync');

/*------------------------Chargez les données -----------------------------*/
const csvContent = fs.readFileSync('donnees.csv', 'utf-8');
const records = parse(csvContent, {columns: true});

/*-----------------------Nettoyez et préparez les données  -----------------------------*/
const data = records.map((record) => {
    const date = new Date(record['Date_Heure']);
    return {
      ...record,
      hour: date.getHours(),
      month: date.getMonth() + 1,
    };
  }).filter((record) => record['Température'] !== '' && record['Humidité'] !== '' && record['Vitesse du vent moyen 10 mn'] !== '' && record['consommation'] !== '');

/*---------------------Sélectionnez les caractéristiques et la cible ---------------------*/

  const X = data.map(({ Température, Humidité, 'Vitesse du vent moyen 10 mn': windSpeed, hour, month }) => [parseFloat(Température), parseFloat(Humidité), parseFloat(windSpeed), hour, month]);
  const y = data.map((record) => parseFloat(record['consommation']));

/*--------------------Divisez les données en ensembles d'apprentissage et de test -------------*/
  const { trainX, trainY, testX, testY } = preprocess.trainTestSplit(X, y, { testSize: 0.2, seed: 42 });
/*--------------Entraînez le modèle -----------------------*/
const model = new RandomForestRegression({ seed: 42 });
model.train(trainX, trainY);
/*--------------Évaluez le modèle  -----------------------*/
const yPred = model.predict(testX);
const mse = preprocess.meanSquaredError(testY, yPred);
const rmse = Math.sqrt(mse);
console.log("RMSE: ", rmse);
/*--------------------------------Prévoyez la consommation d'énergie pour le prochain jour :---*/
const predictedWeatherData = [température, humidité, vitesse_du_vent, heure, mois];
const predictedConsumption = model.predict([predictedWeatherData]);
console.log("Consommation prévue pour le prochain jour : ", predictedConsumption[0]);

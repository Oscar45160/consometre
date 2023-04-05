DROP TABLE donnees_meteo_selectionnees;
DROP TABLE donnees_pour_conso;
DROP TABLE conso;
DROP TABLE donnees_pour_conso_1;
DROP TABLE donnees_pour_conso_2;
DROP TABLE donnees_pour_conso_3;
DROP TABLE donnees_pour_conso_4;

CREATE TABLE donnees_meteo_selectionnees (
    casse_pied FLOAT,
    Date_Heure timestamp, 
    Pression_niveau_mere FLOAT,
    Variation_3_heures FLOAT,
    tendance_barometrique FLOAT,
    Direction_vent_moyen_10mn FLOAT,
    Vitesse_vent_moyen_10mn FLOAT,
    Temperature FLOAT,
    Point_de_rosee FLOAT,
    Humidite FLOAT,
    Visibilite_horizontale FLOAT,
    Temps_present FLOAT,
    Pression_station FLOAT,
    Rafales_sur_une_periode FLOAT,
    Periode_mesure_rafale FLOAT,
    Precipitations_derniere_heure FLOAT,
    Precipitations_3_derniere_heures FLOAT,
    Temperature_Celsius FLOAT,
    Consommation FLOAT,
    datehour FLOAT,
    datemonth FLOAT
);

INSERT INTO donnees_meteo_selectionnees (casse_pied, Date_Heure, Pression_niveau_mere, Variation_3_heures, tendance_barometrique, Direction_vent_moyen_10mn, Vitesse_vent_moyen_10mn, Temperature, Point_de_rosee, Humidite, Visibilite_horizontale, Temps_present, Pression_station, Rafales_sur_une_periode, Periode_mesure_rafale, Precipitations_derniere_heure, Precipitations_3_derniere_heures, Temperature_Celsius, Consommation, datehour, datemonth)
SELECT *
FROM donnees_meteo
WHERE EXTRACT(day FROM Date_Heure) = EXTRACT(day FROM TO_TIMESTAMP('05/01/2022', 'DD/MM/YYYY')) 
    AND EXTRACT(month FROM Date_Heure) = EXTRACT(month FROM TO_TIMESTAMP('05/01/2022', 'DD/MM/YYYY'))
    OR Date_Heure BETWEEN DATE_TRUNC('day', CAST('2022-01-01' AS TIMESTAMP)) - INTERVAL '4 DAY' AND '05/01/2022';


CREATE TABLE donnees_pour_conso (
    casse_pied FLOAT,
    Pression_niveau_mere FLOAT,
    Variation_3_heures FLOAT,
    tendance_barometrique FLOAT,
    Direction_vent_moyen_10mn FLOAT,
    Vitesse_vent_moyen_10mn FLOAT,
    Temperature FLOAT,
    Point_de_rosee FLOAT,
    Humidite FLOAT,
    Visibilite_horizontale FLOAT,
    Temps_present FLOAT,
    Pression_station FLOAT,
    Rafales_sur_une_periode FLOAT,
    Periode_mesure_rafale FLOAT,
    Precipitations_derniere_heure FLOAT,
    Precipitations_3_derniere_heures FLOAT,
    Temperature_Celsius FLOAT,
    datehour FLOAT,
    datemonth FLOAT
);

INSERT INTO donnees_pour_conso (casse_pied, Pression_niveau_mere, Variation_3_heures, tendance_barometrique, Direction_vent_moyen_10mn, Vitesse_vent_moyen_10mn, Temperature, Point_de_rosee, Humidite, Visibilite_horizontale, Temps_present, Pression_station, Rafales_sur_une_periode, Periode_mesure_rafale, Precipitations_derniere_heure, Precipitations_3_derniere_heures, Temperature_Celsius, datehour, datemonth)
SELECT AVG(casse_pied), AVG(Pression_niveau_mere), AVG(Variation_3_heures), AVG(tendance_barometrique), AVG(Direction_vent_moyen_10mn), AVG(Vitesse_vent_moyen_10mn), AVG(Temperature),  AVG(Point_de_rosee),AVG(Humidite),AVG(Visibilite_horizontale),AVG(Temps_present),AVG(Pression_station),AVG(Rafales_sur_une_periode),AVG(Periode_mesure_rafale),AVG(Precipitations_derniere_heure),AVG(Precipitations_3_derniere_heures),AVG(Temperature_Celsius),AVG(datehour),AVG(datemonth)
FROM donnees_meteo_selectionnees;




CREATE TABLE conso(
    Point_de_rosee FLOAT,
    Humidite FLOAT,
    Temperature_Celsius FLOAT,
    Consommation FLOAT
);

INSERT INTO conso (Point_de_rosee, Humidite, Temperature_Celsius, Consommation)
SELECT DM.Point_de_rosee, DM.Humidite,DM.Temperature_Celsius, DM.Consommation
FROM donnees_meteo DM
JOIN donnees_pour_conso DPC ON ABS(DM.Temperature_Celsius - DPC.Temperature_Celsius) / ((ABS(DM.Temperature_Celsius) + ABS(DPC.Temperature_Celsius)) / 2) < 0.01
                            AND ABS(DM.Point_de_rosee - DPC.Point_de_rosee) / ((ABS(DM.Point_de_rosee) + ABS(DPC.Point_de_rosee)) / 2) < 0.01
                            AND ABS(DM.Humidite - DPC.Humidite) / ((ABS(DM.Humidite) + ABS(DPC.Humidite)) / 2) < 0.01;

SELECT AVG(Consommation) * 8 as Journee
FROM conso;

CREATE TABLE donnees_pour_conso_1 (
    casse_pied FLOAT,
    Pression_niveau_mere FLOAT,
    Variation_3_heures FLOAT,
    tendance_barometrique FLOAT,
    Direction_vent_moyen_10mn FLOAT,
    Vitesse_vent_moyen_10mn FLOAT,
    Temperature FLOAT,
    Point_de_rosee FLOAT,
    Humidite FLOAT,
    Visibilite_horizontale FLOAT,
    Temps_present FLOAT,
    Pression_station FLOAT,
    Rafales_sur_une_periode FLOAT,
    Periode_mesure_rafale FLOAT,
    Precipitations_derniere_heure FLOAT,
    Precipitations_3_derniere_heures FLOAT,
    Temperature_Celsius FLOAT,
    datehour FLOAT,
    datemonth FLOAT
);

INSERT INTO donnees_pour_conso_1 (casse_pied, Pression_niveau_mere, Variation_3_heures, tendance_barometrique, Direction_vent_moyen_10mn, Vitesse_vent_moyen_10mn, Temperature, Point_de_rosee, Humidite, Visibilite_horizontale, Temps_present, Pression_station, Rafales_sur_une_periode, Periode_mesure_rafale, Precipitations_derniere_heure, Precipitations_3_derniere_heures, Temperature_Celsius, datehour, datemonth)
SELECT AVG(casse_pied), AVG(Pression_niveau_mere), AVG(Variation_3_heures), AVG(tendance_barometrique), AVG(Direction_vent_moyen_10mn), AVG(Vitesse_vent_moyen_10mn), AVG(Temperature),  AVG(Point_de_rosee),AVG(Humidite),AVG(Visibilite_horizontale),AVG(Temps_present),AVG(Pression_station),AVG(Rafales_sur_une_periode),AVG(Periode_mesure_rafale),AVG(Precipitations_derniere_heure),AVG(Precipitations_3_derniere_heures),AVG(Temperature_Celsius),AVG(datehour),AVG(datemonth)
FROM donnees_meteo_selectionnees DMS
WHERE DMS.datehour BETWEEN 0 AND 5;

CREATE TABLE conso_1(
    Point_de_rosee FLOAT,
    Humidite FLOAT,
    Temperature_Celsius FLOAT,
    Consommation FLOAT
);

INSERT INTO conso_1 (Point_de_rosee, Humidite, Temperature_Celsius, Consommation)
SELECT DM.Point_de_rosee, DM.Humidite,DM.Temperature_Celsius, DM.Consommation
FROM donnees_meteo DM 
JOIN donnees_pour_conso_1 DPC ON ABS(DM.Temperature_Celsius - DPC.Temperature_Celsius) / ((ABS(DM.Temperature_Celsius) + ABS(DPC.Temperature_Celsius)) / 2) < 0.01
                            AND ABS(DM.Point_de_rosee - DPC.Point_de_rosee) / ((ABS(DM.Point_de_rosee) + ABS(DPC.Point_de_rosee)) / 2) < 0.01
                            AND ABS(DM.Humidite - DPC.Humidite) / ((ABS(DM.Humidite) + ABS(DPC.Humidite)) / 2) < 0.01
WHERE DM.datehour BETWEEN 0 AND 5;

SELECT AVG(Consommation) * 2 as nuit
FROM conso_1;

CREATE TABLE donnees_pour_conso_2 (
    casse_pied FLOAT,
    Pression_niveau_mere FLOAT,
    Variation_3_heures FLOAT,
    tendance_barometrique FLOAT,
    Direction_vent_moyen_10mn FLOAT,
    Vitesse_vent_moyen_10mn FLOAT,
    Temperature FLOAT,
    Point_de_rosee FLOAT,
    Humidite FLOAT,
    Visibilite_horizontale FLOAT,
    Temps_present FLOAT,
    Pression_station FLOAT,
    Rafales_sur_une_periode FLOAT,
    Periode_mesure_rafale FLOAT,
    Precipitations_derniere_heure FLOAT,
    Precipitations_3_derniere_heures FLOAT,
    Temperature_Celsius FLOAT,
    datehour FLOAT,
    datemonth FLOAT
);

INSERT INTO donnees_pour_conso_2 (casse_pied, Pression_niveau_mere, Variation_3_heures, tendance_barometrique, Direction_vent_moyen_10mn, Vitesse_vent_moyen_10mn, Temperature, Point_de_rosee, Humidite, Visibilite_horizontale, Temps_present, Pression_station, Rafales_sur_une_periode, Periode_mesure_rafale, Precipitations_derniere_heure, Precipitations_3_derniere_heures, Temperature_Celsius, datehour, datemonth)
SELECT AVG(casse_pied), AVG(Pression_niveau_mere), AVG(Variation_3_heures), AVG(tendance_barometrique), AVG(Direction_vent_moyen_10mn), AVG(Vitesse_vent_moyen_10mn), AVG(Temperature),  AVG(Point_de_rosee),AVG(Humidite),AVG(Visibilite_horizontale),AVG(Temps_present),AVG(Pression_station),AVG(Rafales_sur_une_periode),AVG(Periode_mesure_rafale),AVG(Precipitations_derniere_heure),AVG(Precipitations_3_derniere_heures),AVG(Temperature_Celsius),AVG(datehour),AVG(datemonth)
FROM donnees_meteo_selectionnees DMS
WHERE DMS.datehour BETWEEN 6 AND 11;


CREATE TABLE conso_2(
    Point_de_rosee FLOAT,
    Humidite FLOAT,
    Temperature_Celsius FLOAT,
    Consommation FLOAT
);

INSERT INTO conso_2 (Point_de_rosee, Humidite, Temperature_Celsius, Consommation)
SELECT DM.Point_de_rosee, DM.Humidite,DM.Temperature_Celsius, DM.Consommation
FROM donnees_meteo DM 
JOIN donnees_pour_conso_2 DPC ON ABS(DM.Temperature_Celsius - DPC.Temperature_Celsius) / ((ABS(DM.Temperature_Celsius) + ABS(DPC.Temperature_Celsius)) / 2) < 0.01
                            AND ABS(DM.Point_de_rosee - DPC.Point_de_rosee) / ((ABS(DM.Point_de_rosee) + ABS(DPC.Point_de_rosee)) / 2) < 0.01
                            AND ABS(DM.Humidite - DPC.Humidite) / ((ABS(DM.Humidite) + ABS(DPC.Humidite)) / 2) < 0.01
WHERE DM.datehour BETWEEN 6 AND 11;

SELECT AVG(Consommation) * 2 as matin
FROM conso_2;

CREATE TABLE donnees_pour_conso_3 (
    casse_pied FLOAT,
    Pression_niveau_mere FLOAT,
    Variation_3_heures FLOAT,
    tendance_barometrique FLOAT,
    Direction_vent_moyen_10mn FLOAT,
    Vitesse_vent_moyen_10mn FLOAT,
    Temperature FLOAT,
    Point_de_rosee FLOAT,
    Humidite FLOAT,
    Visibilite_horizontale FLOAT,
    Temps_present FLOAT,
    Pression_station FLOAT,
    Rafales_sur_une_periode FLOAT,
    Periode_mesure_rafale FLOAT,
    Precipitations_derniere_heure FLOAT,
    Precipitations_3_derniere_heures FLOAT,
    Temperature_Celsius FLOAT,
    datehour FLOAT,
    datemonth FLOAT
);

INSERT INTO donnees_pour_conso_3 (casse_pied, Pression_niveau_mere, Variation_3_heures, tendance_barometrique, Direction_vent_moyen_10mn, Vitesse_vent_moyen_10mn, Temperature, Point_de_rosee, Humidite, Visibilite_horizontale, Temps_present, Pression_station, Rafales_sur_une_periode, Periode_mesure_rafale, Precipitations_derniere_heure, Precipitations_3_derniere_heures, Temperature_Celsius, datehour, datemonth)
SELECT AVG(casse_pied), AVG(Pression_niveau_mere), AVG(Variation_3_heures), AVG(tendance_barometrique), AVG(Direction_vent_moyen_10mn), AVG(Vitesse_vent_moyen_10mn), AVG(Temperature),  AVG(Point_de_rosee),AVG(Humidite),AVG(Visibilite_horizontale),AVG(Temps_present),AVG(Pression_station),AVG(Rafales_sur_une_periode),AVG(Periode_mesure_rafale),AVG(Precipitations_derniere_heure),AVG(Precipitations_3_derniere_heures),AVG(Temperature_Celsius),AVG(datehour),AVG(datemonth)
FROM donnees_meteo_selectionnees DMS
WHERE DMS.datehour BETWEEN 12 AND 17;

CREATE TABLE conso_3(
    Point_de_rosee FLOAT,
    Humidite FLOAT,
    Temperature_Celsius FLOAT,
    Consommation FLOAT
);

INSERT INTO conso_3 (Point_de_rosee, Humidite, Temperature_Celsius, Consommation)
SELECT DM.Point_de_rosee, DM.Humidite,DM.Temperature_Celsius, DM.Consommation
FROM donnees_meteo DM 
JOIN donnees_pour_conso_3 DPC ON ABS(DM.Temperature_Celsius - DPC.Temperature_Celsius) / ((ABS(DM.Temperature_Celsius) + ABS(DPC.Temperature_Celsius)) / 2) < 0.01
                            AND ABS(DM.Point_de_rosee - DPC.Point_de_rosee) / ((ABS(DM.Point_de_rosee) + ABS(DPC.Point_de_rosee)) / 2) < 0.01
                            AND ABS(DM.Humidite - DPC.Humidite) / ((ABS(DM.Humidite) + ABS(DPC.Humidite)) / 2) < 0.01
WHERE DM.datehour BETWEEN 12 AND 17;

SELECT AVG(Consommation) * 2 as apres_midi
FROM conso_3;

CREATE TABLE donnees_pour_conso_4 (
    casse_pied FLOAT,
    Pression_niveau_mere FLOAT,
    Variation_3_heures FLOAT,
    tendance_barometrique FLOAT,
    Direction_vent_moyen_10mn FLOAT,
    Vitesse_vent_moyen_10mn FLOAT,
    Temperature FLOAT,
    Point_de_rosee FLOAT,
    Humidite FLOAT,
    Visibilite_horizontale FLOAT,
    Temps_present FLOAT,
    Pression_station FLOAT,
    Rafales_sur_une_periode FLOAT,
    Periode_mesure_rafale FLOAT,
    Precipitations_derniere_heure FLOAT,
    Precipitations_3_derniere_heures FLOAT,
    Temperature_Celsius FLOAT,
    datehour FLOAT,
    datemonth FLOAT
);

INSERT INTO donnees_pour_conso_4 (casse_pied, Pression_niveau_mere, Variation_3_heures, tendance_barometrique, Direction_vent_moyen_10mn, Vitesse_vent_moyen_10mn, Temperature, Point_de_rosee, Humidite, Visibilite_horizontale, Temps_present, Pression_station, Rafales_sur_une_periode, Periode_mesure_rafale, Precipitations_derniere_heure, Precipitations_3_derniere_heures, Temperature_Celsius, datehour, datemonth)
SELECT AVG(casse_pied), AVG(Pression_niveau_mere), AVG(Variation_3_heures), AVG(tendance_barometrique), AVG(Direction_vent_moyen_10mn), AVG(Vitesse_vent_moyen_10mn), AVG(Temperature),  AVG(Point_de_rosee),AVG(Humidite),AVG(Visibilite_horizontale),AVG(Temps_present),AVG(Pression_station),AVG(Rafales_sur_une_periode),AVG(Periode_mesure_rafale),AVG(Precipitations_derniere_heure),AVG(Precipitations_3_derniere_heures),AVG(Temperature_Celsius),AVG(datehour),AVG(datemonth)
FROM donnees_meteo_selectionnees DMS
WHERE DMS.datehour BETWEEN 18 AND 23;

CREATE TABLE conso_4(
    Point_de_rosee FLOAT,
    Humidite FLOAT,
    Temperature_Celsius FLOAT,
    Consommation FLOAT
);

INSERT INTO conso_4 (Point_de_rosee, Humidite, Temperature_Celsius, Consommation)
SELECT DM.Point_de_rosee, DM.Humidite,DM.Temperature_Celsius, DM.Consommation
FROM donnees_meteo DM 
JOIN donnees_pour_conso_4 DPC ON ABS(DM.Temperature_Celsius - DPC.Temperature_Celsius) / ((ABS(DM.Temperature_Celsius) + ABS(DPC.Temperature_Celsius)) / 2) < 0.01
                            AND ABS(DM.Point_de_rosee - DPC.Point_de_rosee) / ((ABS(DM.Point_de_rosee) + ABS(DPC.Point_de_rosee)) / 2) < 0.01
                            AND ABS(DM.Humidite - DPC.Humidite) / ((ABS(DM.Humidite) + ABS(DPC.Humidite)) / 2) < 0.01
WHERE DM.datehour BETWEEN 18 AND 23;

SELECT AVG(Consommation) * 2 as soir
FROM conso_4;

/*
DROP TABLE donnees_meteo_selectionnees;
DROP TABLE donnees_pour_conso;
DROP TABLE conso;
DROP TABLE donnees_pour_conso_1;
DROP TABLE donnees_pour_conso_2;
DROP TABLE donnees_pour_conso_3;
DROP TABLE donnees_pour_conso_4;
*/
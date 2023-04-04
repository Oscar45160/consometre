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

INSERT INTO donnees_meteo_selectionnees (casse_pied, Pression_niveau_mere, Variation_3_heures, tendance_barometrique, Direction_vent_moyen_10mn, Vitesse_vent_moyen_10mn, Temperature, Point_de_rosee, Humidite, Visibilite_horizontale, Temps_present, Pression_station, Rafales_sur_une_periode, Periode_mesure_rafale, Precipitations_derniere_heure, Precipitations_3_derniere_heures, Temperature_Celsius, datehour, datemonth)
SELECT AVG(casse_pied), AVG(Pression_niveau_mere), AVG(Variation_3_heures), AVG(tendance_barometrique), AVG(Direction_vent_moyen_10mn), AVG(Vitesse_vent_moyen_10mn), AVG(Temperature),  AVG(Point_de_rosee),AVG(Humidite),AVG(Visibilite_horizontale),AVG(Temps_present),AVG(Pression_station),AVG(Rafales_sur_une_periode),AVG(Periode_mesure_rafale),AVG(Precipitations_derniere_heure),AVG(Precipitations_3_derniere_heures),AVG(Temperature_Celsius),AVG(datehour),AVG(datemonth),
FROM donnees_meteo_selectionnees;

CREATE TABLE donnees_meteo (
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
COPY donnees_meteo FROM '/workspaces/consometre/new_data.csv' DELIMITER ',' CSV HEADER;


const express = require('express');
const pgp = require('pg-promise')();
const bodyParser = require('body-parser');
const cors = require('cors');
const path = require('path');

const app = express();
const db = pgp('postgres://postgres:root@localhost:5432/postgres');

const { Pool } = require('pg');

app.use(cors());
app.use(express.static(path.join(__dirname, 'public')));

app.use(bodyParser.json());

app.post('/Route', (req, res) => {
    const date1 = req.body.date1;
    const date2 = req.body.date2;

    db.any(`SELECT * FROM donnees_meteo WHERE EXTRACT(day FROM Date_Heure) = EXTRACT(day FROM TO_TIMESTAMP($1, 'YYYY-MM-DD')) AND EXTRACT(month FROM Date_Heure) = EXTRACT(month FROM TO_TIMESTAMP($1, 'YYYY-MM-DD')) OR Date_Heure BETWEEN DATE_TRUNC('day',CAST($2 AS TIMESTAMP)) - INTERVAL '4 DAY' AND $1;`, [date1, date2])
});

app.get('/api/data', async (req, res) => {
    try {
      const conso = await db.one('SELECT AVG(Consommation) * 8 AS average FROM conso');
      const conso1 = await db.one('SELECT AVG(Consommation) * 2 AS average FROM conso_1');
      const conso2 = await db.one('SELECT AVG(Consommation) * 2 AS average FROM conso_2');
      const conso3 = await db.one('SELECT AVG(Consommation) * 2 AS average FROM conso_3');
      const conso4 = await db.one('SELECT AVG(Consommation) * 2 AS average FROM conso_4');
  
      res.json({
        conso: conso.average,
        conso1: conso1.average,
        conso2: conso2.average,
        conso3: conso3.average,
        conso4: conso4.average
      });

    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Failed to fetch data' });
    }
});

// app.get('/api/data', async (req, res) => {
//   try {
//       const date1 = '';
//       const dateFormat = 'DD/MM/YYYY';
//       const date2 = '';
//       const date = await db.one('SELECT * FROM donnees_meteo WHERE EXTRACT(day FROM Date_Heure) = EXTRACT(day FROM TO_TIMESTAMP($1, $2)) AND EXTRACT(month FROM Date_Heure) = EXTRACT(month FROM TO_TIMESTAMP($1, $2)) OR Date_Heure BETWEEN DATE_TRUNC($3::text, CAST($4 AS TIMESTAMP)) - INTERVAL $5 AND $1;', [date1, dateFormat, 'day', date2, '4 DAY']);

//   } catch (err) {
//     console.error(err);
//     res.status(500).json({ error: 'Failed to fetch data' });
//   }
// });

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

const express = require('express');
const pgp = require('pg-promise')();
const bodyParser = require('body-parser');
const cors = require('cors');
const path = require('path');
const app = express();
const db = pgp('postgres://postgres:root@localhost:5432/postgres');
const { Pool } = require('pg');
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.json());

app.get('/api/data/:date', async (req, res) => {
    const date = req.params.date

    // fait a la pisse
    let dateTmp = new Date(date);
    dateTmp.setDate(dateTmp.getDate() - 4);
    let year = dateTmp.getFullYear();
    let month = ("0" + (dateTmp.getMonth() + 1)).slice(-2);
    let day = ("0" + dateTmp.getDate()).slice(-2);
    const dateMoins4 = `${year}-${month}-${day}`;

    try {
      const conso = await db.one('SELECT AVG(Consommation) * 8 AS average FROM conso');
      const conso1 = await db.one('SELECT AVG(Consommation) * 2 AS average FROM conso_1');
      const conso2 = await db.one('SELECT AVG(Consommation) * 2 AS average FROM conso_2');
      const conso3 = await db.one('SELECT AVG(Consommation) * 2 AS average FROM conso_3');
      const conso4 = await db.one('SELECT AVG(Consommation) * 2 AS average FROM conso_4');
  
      res.json({
        conso: date,
        conso1: dateMoins4,
        conso2: conso2.average,
        conso3: conso3.average,
        conso4: conso4.average
      });

    } catch (err) {
      console.error(err);
      res.status(500).json({ error: 'Failed to fetch data' });
    }
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
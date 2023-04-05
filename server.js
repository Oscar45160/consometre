const express = require('express');
const pgp = require('pg-promise')();
const cors = require('cors');

const app = express();
const db = pgp('postgres://postgres:root@localhost:5432/postgres');

app.use(cors());

app.get('/api/data', async (req, res) => {
  try {
    const conso = await db.one('SELECT AVG(Consommation) * 8 AS average FROM conso');
    res.json(conso);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Failed to fetch data' });
  }
});

const PORT = process.env.PORT || 2500;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

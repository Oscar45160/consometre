const pgp = require('pg-promise')();
const db = pgp('postgres://postgres:root@localhost:5432/postgres');

async function main() {
  try {
    const conso = await db.one('SELECT AVG(Consommation) * 8 AS average FROM conso');
    console.log(conso);

    const conso1 = await db.one('SELECT AVG(Consommation) * 2 AS average FROM conso_1');
    console.log(conso1);

    const conso2 = await db.one('SELECT AVG(Consommation) * 2 AS average FROM conso_2');
    console.log(conso2);

    const conso3 = await db.one('SELECT AVG(Consommation) * 2 AS average FROM conso_3');
    console.log(conso3);

    const conso4 = await db.one('SELECT AVG(Consommation) * 2 AS average FROM conso_4');
    console.log(conso4);
  } catch (err) {
    console.error(err);
  } finally {
    db.$pool.end();
  }
}

main();

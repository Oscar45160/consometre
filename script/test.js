const pgp = require('pg-promise')();
const db = pgp('postgres://postgres:root@localhost:5432/postgres');

db.one('SELECT NOW()')
  .then((result) => {
    console.log('Résultat de la requête :', result);
  })
  .catch((error) => {
    console.error('Erreur lors de l\'exécution de la requête', error);
  })
  .finally(() => {
    pgp.end();
  });

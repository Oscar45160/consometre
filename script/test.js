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



  fetch('/api/data', {
    method: 'POST',
    body: JSON.stringify({ date: date }),
    headers: {
        'Content-Type': 'application/json'
    }
    })
    .then(response => {
        if (!response.ok) {
        throw new Error(`Error: ${response.statusText}`);
        }
        return response.json();
    })
    .then(data => {
        // Traiter les données renvoyées par le serveur, par exemple, afficher les prévisions météorologiques
        console.log(data);
    })
    .catch(error => {
        console.error('Error fetching data:', error);
    });
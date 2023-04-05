const pgp = require('pg-promise')();
const db = pgp('postgres://postgres:@host:5432/postgres');


client.connect()

client.query('SELECT AVG(Consommation) * 8 FROM conso', (err, res) => {
    if (err) {
      console.error(err)
      return
    }
    const conso = res.rows
    console.log(conso)
  })
  
client.query('SELECT AVG(Consommation) * 2 FROM conso_1', (err, res) => {
  if (err) {
    console.error(err)
    return
  }
  const conso1 = res.rows
  console.log(conso1)
})

client.query('SELECT AVG(Consommation) * 2 FROM conso_2', (err, res) => {
  if (err) {
    console.error(err)
    return
  }
  const conso2 = res.rows
  console.log(conso2)
})

client.query('SELECT AVG(Consommation) * 2 FROM conso_3', (err, res) => {
  if (err) {
    console.error(err)
    return
  }
  const conso3 = res.rows
  console.log(conso3)
})

client.query('SELECT AVG(Consommation) * 2 FROM conso_4', (err, res) => {
  if (err) {
    console.error(err)
    return
  }
  const conso4 = res.rows
  console.log(conso4)
})

client.end()
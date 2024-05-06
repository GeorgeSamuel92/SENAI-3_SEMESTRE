const mysql2 = require("mysql2/promise");

async function connect() {
    if (global.connection && global.connection.state !== "disconnected") {
      return global.connection;
    }
    const con = await mysql2.createConnection({
      port: "3306",
      database: "bd_clientes",
      user: "root",
      password: "1234",
    });
  
    console.log("Conectado ao banco de dados!");
    global.connection = con;
    return con;
  }

  module.exports = { connect };

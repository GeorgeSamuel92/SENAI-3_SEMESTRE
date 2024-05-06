const express = require("express");
const clienteRoute = require("./src/routers/clienteRoute");

const app = express();

app.use(express.json());

app.use('/', clienteRoute) ;

app.listen(3000, () => {
    console.log("Servidor iniciado na porta 3000");
});

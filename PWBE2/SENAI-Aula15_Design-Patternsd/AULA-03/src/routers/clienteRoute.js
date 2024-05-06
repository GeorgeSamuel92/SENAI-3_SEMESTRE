const express = require('express');

const router = express.Router();

const {clienteController} = require('../controllers/clienteController');

router.get('/clientes', clienteController.selecionaTodosClientes);
router.get('/clientes/:id', clienteController.selecionaCliente);
router.post('/clientes', clienteController.adcionaCliente);
router.put('/clientes/:id', clienteController.alternaCliente);
router.delete('/clientes/:id', clienteController.deletarCliente);

module.exports = router;
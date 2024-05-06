
const clienteModel = require("../models/clienteModel");

const clienteController = {
  //retorna todos os clientes na tabela clientes
  selecionaTodosClientes: async (req, res) => {
    try {
      const clientes = await clienteModel.selecionaTodosClientes();
      return res.json(clientes);
    } catch (error) {
      throw error;
    }
  },

  //retorna o cliente com base no id informado
  selecionaCliente: async (req, res) => {
    try {
      const { id } = req.params;
      const cliente = await clienteModel.selecionaUmCliente(id);
      return res.json(cliente);
    } catch (error) {
      throw error;
    }
  },

  //creater - cria um novo cliente
  adcionaCliente: async (req, res) => {
    try {
      const { nome, idade } = req.body;
      const result = await clienteModel.inserirCliente({
        nome: nome,
        idade: idade,
      });
      console.log(result);
      const cliente = await clienteModel.selecionaTodosClientes();
      return res.json(cliente);
    } catch (error) {
      throw error;
    }
  },

  //update - altera um cliente
  alternaCliente: async (req, res) => {
    try {
      const { id } = req.params;
      const { nome, idade } = req.body;

      const result = await clienteModel.atualizarCliente(id, { nome: nome,idade: idade});
      return res.json("clienete alterado com sucesso")
    } catch (error){
      throw error;
    }
  },

    //delete - deleta um cliente
    deletarCliente: async (req, res) => {
      try {
        const { id } = req.params;
        //   return res.json(await deleteCliente(id), {
        //     messagem: `Registro deletado com sucesso!`});
        var result = await clienteModel.excluirClientes(id);
        if (result[0].affectedRows > 0) {
          return res.status(200).send(`Registro deletado com sucesso!`);
        } else {
          return res.send(`Erro ao deletar o registro`);
        }
      } catch (error) {
        throw error;
      }
    }
  };


module.exports = { clienteController };

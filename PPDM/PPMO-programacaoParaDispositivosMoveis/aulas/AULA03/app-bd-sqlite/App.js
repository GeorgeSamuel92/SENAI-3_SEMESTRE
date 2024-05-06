import React, { useState, useEffect } from "react";
import {
  StyleSheet,
  Text,
  View,
  Button,
  TextInput,
  Alert,
  SafeAreaView,
  Platform,
  ScrollView,
  TouchableOpacity,
} from "react-native";
import { getStatusBarHeight } from "react-native-status-bar-height";
import { DatabaseConnection } from "./src/database/database";
import { SafeAreaProvider } from "react-native-safe-area-context";
import FontAwesome6 from "react-native-vector-icons/FontAwesome6";

/**
 * Abra ou crie o banco de dados SQLite
 */

const db = new DatabaseConnection.getConnection(); //

export default function App() {
  const [todos, setTodos] = useState([]);
  const [inputText, setInputText] = useState("");
  const [operacao, setOperacao] = useState("incluir");
  const [id, setId] = useState(null);

  /**
   * Função dentro do useEffect que cria a tabela caso ela não exista
   */
  useEffect(() => {
    db.transaction((tx) => {
      tx.executeSql(
        "CREATE TABLE IF NOT EXISTS clientes (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL)",
        [], //[]: Este é o array de parâmetros. Como não estamos usando nenhum parâmetro na consulta SQL, deixamos esse array vazio.
        () => console.log("Tabela criada com sucesso"), //retorno de  sucesso
        // '_' É um parâmetro que representa o resultado da transação SQL, por convenção utiliza-se o underscore. para indicar que estamos ignorando esse valor.
        (_, error) => console.error(error) //retorno de  erro
      );
    }, null);
  }, [todos]);

  /**
   * Função utilizada para atualizar os registros
   */
  const atualizaRegistros = () => {
    try {
      db.transaction((tx) => {
        tx.executeSql(
          "SELECT * FROM clientes",
          //'_array' é uma propriedade do objeto rows retornado pela consulta SQL, em rows._array, o '_' não se refere diretamente a rows, mas sim ao objeto retornado pela transação SQL.
          [],
          (_, { rows }) =>
            // O '_array' é uma propriedade desse objeto que contém os resultados da consulta em forma de array.
            setTodos(rows._array)
        );
      });
    } catch (error) {
      console.error("Erro ao buscar todos:", error);
    }
  };

  /**
   * useEffect que chama a função para atualizar os registros
   */
  useEffect(() => {
    atualizaRegistros();
  }, []);

  /**
   * Função utilizada inserir um novo registro
   */
  const incluiCliente = () => {
    if (inputText.trim() === " ") {
      Alert.alert(
        "Erro",
        "Por favor, insira um texto válido para adicionar o cliente"
      );
      return;
    }

    if (operacao === "incluir") {
      db.transaction((tx) => {
        tx.executeSql(
          "INSERT INTO clientes (nome) VALUES (?)",
          [inputText],
          (_, { rowsAffected }) => {
            console.log(rowsAffected);
            setInputText(" ");
            atualizaRegistros();
          },
          (_, error) => {
            console.error("Erro ao adicionar cliente:", error);
            Alert.alert("Erro", "Ocorreu um erro ao adicionar o cliente.");
          }
        );
      });
    } else if (operacao === "Editar") {
      db.transaction((tx) => {
        tx.executeSql(
          "UPDATE clientes SET nome = ? WHERE id = ?",
          [inputText, id],
          (_, { rowsAffected }) => {
            if (rowsAffected === 1)
              Alert.alert("Sucesso", "Cliente atualizado com sucesso");
            else if (rowsAffected === 0)
              Alert.alert("Alerta", "Nenhum registro foi alterado");

            setInputText("");
            atualizaRegistros();
            setOperacao("incluir");
          },
          (_, error) => {
            console.error("Erro ao adicionar cliente:", error);
            Alert.alert("Erro", "Ocorreu um erro ao adicionar o cliente.");
          }
        );
      });
    }

    db.transaction((tx) => {
      tx.executeSql(
        "UPDATE clientes SET nome =? WHERE id =?",
        [inputText, id],
        (_, { rowsAffected }) => {
          console.log(rowsAffected);
          setInputText("");
          atualizaRegistros();
        },
        (_, error) => {
          console.error("Erro ao atualizar cliente:", error);
          Alert.alert("Erro", "Ocorreu um erro ao atualizar o cliente.");
        }
      );
    });
  };

  /**
   * Função excluir registro
   */

  const excluiCliente = (id) => {
    db.transaction((tx) => {
      tx.executeSql(
        "DELETE FROM clientes WHERE id = ?",
        [id],
        (_, { rowsAffected }) => {
          if (rowsAffected > 0) {
            atualizaRegistros();
            Alert.alert("Sucesso", "Cliente excluído com sucesso");
          } else {
            Alert.alert(
              "Error",
              "Registro não execcultado, verifique e tante novamente"
            );
          }
        },
        (_, error) => {
          console.log("Erro ao excluir cliente:", error);
          Alert.alert("Erro", "Ocorreu um erro ao excluir o cliente");
        }
      );
    });
  };
<<<<<<< HEAD

=======
>>>>>>> be92bb31f5552088b8ebb3978342a83f130ff1ef
  // função de edição do cliente
  const buttonPress = (nome) => {
    setInputText(nome);
  };

  /**
   * Função atualizar para excluir tabelas e banco
   */

  const deleteDatabase = () => {
    db.transaction((tx) => {
      tx.executeSql(
        "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'",
        [],
        (_, { rows }) => {
          rows._array.forEach((table) => {
            tx.executeSql(
              `DROP TABLE IF EXISTS ${table.name}`,
              [],
              () => {
                console.log(`Tabela ${table.name} excluída com sucesso!`);
                setTodos([]);
              },
              (_, error) => {
                console.log(`Erro ao excluir tabela ${table.name}:`, error);
                Alert.alert(
                  "Erro",
                  `Ocorreu um erro ao excluir a tabela ${table.name}`
                );
              }
            );
          });
        }
      );
    });
  };

  return (
    <SafeAreaProvider>
      <SafeAreaView style={styles.androidSafeArea}>
        <View style={styles.container}>
          <TextInput
            style={styles.input}
            value={inputText}
            onChangeText={setInputText}
            placeholder="Digite um novo cliente"
          />

          <Button
            title={
              operacao === "incluir"
                ? "Salvar Novo Registro"
                : "Salvar Alteração"
            }
            onPress={incluiCliente}
          />

          <Text style={styles.title}>Clientes Cadastrados</Text>
        </View>

        <ScrollView contentContainerStyle={{ flexGrow: 1 }}>
          <View style={styles.containerScroll}>
            {/* A propriedade key é usada pelo React para identificar de forma única cada elemento na lista, o que é crucial para que o React possa otimizar a renderização e o desempenho. */}
            {todos.map((cliente) => (
              <View key={cliente.id} style={styles.clienteItem}>
                <Text>{cliente.nome}</Text>
                <Text>{cliente.id}</Text>

                <View style={styles.buttonTable}>
                  <TouchableOpacity
                    onPress={() => {
                      buttonPress(cliente.nome),
                        setId(cliente.id),
                        setOperacao("Editar");
                    }}
                  >
                    <FontAwesome6 name="pen-to-square" size={24} color="blue" />
                  </TouchableOpacity>

                  {/* Dentro do onPress do botão, colocamos um alert perguntando ao usuário se deseja excluir o registro selecionado */}

                  <TouchableOpacity
                    onPress={() => {
                      Alert.alert(
                        "Atenção!",
                        "Deseja excluir o registro selecionado?",
                        [
                          {
                            text: "OK",
                            onPress: () => excluiCliente(cliente.id),
                          },
                          {
                            text: "Cancelar",
                            onPress: () => {
                              return;
                            },
                          },
                        ]
                      );
<<<<<<< HEAD
                    }}>

=======
                    }}
                  >
>>>>>>> be92bb31f5552088b8ebb3978342a83f130ff1ef
                    <FontAwesome6 name="trash" size={24} color="red" />
                  </TouchableOpacity>
                </View>
              </View>
            ))}
          </View>
        </ScrollView>
        <TouchableOpacity
          onPress={() => {
            Alert.alert(
              "Atenção!",
              "Deseja excluir o Banco de dados do Sistema? Essa ação não pode ser desfeita!",
              [
                {
                  text: "OK",
                  onPress: () => deleteDatabase(),
                },
                {
                  text: "Cancelar",
                  onPress: () => {
                    return;
                  },
                },
              ]
            );
          }}
        >
          <FontAwesome6 name="eraser" size={50} color="red" />
        </TouchableOpacity>
      </SafeAreaView>
    </SafeAreaProvider>
  );
}

/**
 * Estilização dos componentes
 */
<<<<<<< HEAD

=======
>>>>>>> be92bb31f5552088b8ebb3978342a83f130ff1ef
const styles = StyleSheet.create({
  androidSafeArea: {
    flex: 1,
    paddingTop: Platform.OS === "android" ? getStatusBarHeight() : 0,
    marginTop: 10,
  },
  container: {
    width: "100%",
    backgroundColor: "#fff",
    padding: 20,
    gap: 10,
  },
  containerScroll: {
    width: "100%",
    backgroundColor: "#fff",
    padding: 20,
    gap: 5,
  },
  title: {
    fontSize: 20,
    fontWeight: "bold",
    marginBottom: 10,
  },
  clienteItem: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    marginBottom: 5,
  },
  input: {
    width: "100%",
    borderWidth: 1,
    borderColor: "#ccc",
    borderRadius: 5,
    padding: 10,
    marginBottom: 10,
  },
  button: {
    width: "100%",
    backgroundColor: "#007bff",
    color: "#fff",
    padding: 10,
    borderRadius: 5,
    textAlign: "center",
    fontWeight: "bold",
  },
  bottonTable: {
    flexDirection: "row",
    gap: 15,
  },
});

import React, { useEffect, useState } from "react";
import {
  Text,
  SafeAreaView,
  StyleSheet,
  Button,} from "react-native";
import { usenavigation } from "@react-navigation/native";
import { DatabaseConnection } from '../../database/database';

const db = new DatabaseConnection.getConnection();

export default function Home() {

  //inicio da inclção de codigo

  const [notificationReceived, setNotificationReceived] = useState(null);

  useEffect(() => {
    if(notificationReceived !== null) {
      console.log(notificationReceived);
      const { date, request: { content, identifier, triger} } = notificationReceived

      dados = { date: date, bodyMenssage: constent.body, titleMenssage: content.title, }

      setAllNotifications( prevState => ({
        ...prevState,
        data: [...prevState.data, dados]
      }))
    }
  }, [notificationReceived]);

  //fim da inclução de codigo

  const navigation = usenavigation();

  useEffect(() => {
    db.transaction((tx) => {
      tx.executeSql(
        `CREATE TABLE IF NOT EXISTS filmes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome_filmes TEXT NOT NULL,
            genero TEXT NOT NULL,
            classificacao TEXT NOT NULL,
            data_cad  DATATIME DEFAULT (datetime('now', 'localtime'))
         )`,
        [],
        () => console.log("Tabela criada com sucesso!"),
        (_, error) => console.error(error)
      );
    }, null);
  }, []);

  const navegaCadastrarFilme = () => {
    navigation.navigate("CadastraFilme");
  }

  const navegaEditarFilme = () => {
    navigation.navigate("EditarFilme");
  }

  const navegaExibirFilme = () => {
    navigation.navigate("ExibirFilme");
  }

  const navegaPesquisaFilme= () => {
    navigation.navigate("PesquisaFilme");
  }

  return (
    <SafeAreaView style={styles.container}>
      <Text style={style.title}> Tela HOME</Text>
      <Button title='Cadastrar' onPress={navegaCadastrarFilme}> Cadastra</Button>

      <Button title='Editar' onPress={navegaEditarFilme}>Editar</Button>

      <Button title='Exibir' onPress={navegaExibirFilme}> Exibir</Button>

      <Button title='Pesquisar' onPress={navegaPesquisaFilme}>Pesquisa</Button>

    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroudColor: '#ffffff',
        alignItems: 'center',
        justifyContent: 'center',
        padding: 20
    },
    header: {
        alignItems: 'center',
        marginBottom: 20,
    },
    title: {
      fontSize: 24,
      fontWeight: 'bold',
      marginTop: 10,
  },
  buttonContainer: {
      flexDirection: 'row',
      justifyContent: 'space-around',
      width: '100%',
  },
  button: {
      backgroundColor: '#007bff',
      paddingVertical: 15,
      paddingHorizontal: 40,
      borderRadius: 10,
      marginBottom: 20,
  },
  buttonText: {
      color: 'white',
      fontSize: 18,
      fontWeight: 'bold',
      textAlign: 'center',
  }
})

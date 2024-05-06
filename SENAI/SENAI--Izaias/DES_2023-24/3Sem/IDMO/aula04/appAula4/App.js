/**Nosso App.js será responsável por qual rota deverá exibir */

import { StatusBar } from 'expo-status-bar';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

import Home from './src/pages/Home';
import Sobre from './src/pages/Sobre';

// Navegação tipo pilha, uma página sobre a outra
const Stack = createNativeStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen
          name='Home'
          component={Home}
          options={{
            title: 'Tela Inicial',
            // alterando o estilo do Header
            headerStyle: {
              backgroundColor: '#ff1493'
            },
            // alterando a cor do texto do Header
            headerTintColor: '#fff',
            // Retirar o Header, tela de Login, tela inicial geralmente não tem
            headerShown: false,
            
          }}
        />
        <Stack.Screen name='Sobre' component={Sobre} />
      </Stack.Navigator>
    </NavigationContainer>
  )
}


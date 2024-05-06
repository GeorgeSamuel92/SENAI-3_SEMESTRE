import React from "react";
import { StyleSheet, Text, View } from "react-native";
import { getStatusBarHeight } from "react-native-status-bar-height";
import { SafeAreaProvider } from "react-native-safe-area-context";
import { NavigationContainer } from "@react-navigation/native";
import { StatusBar } from "expo-status-bar";
import { createNativeStackNavigator } from "@react-navigation/native-stack";

import Home from "./src/pages/Home";
import CadastraFilme from "./src/pages/CadastraFilme";
import EditarFilme from "./src/pages/EditarFilme";
import ExibirFilme from "./src/pages/ExibirFilme";
import PesquisaFilme from "./src/pages/PesquisaFilme";

const Stack = createNativeStackNavigator();

export default function App() {
  return (
    <SafeAreaProvider>

      <NavigationContainer style={styles.container}>
        <Stack.Navigator>
          <Tab.Screen name="Home" component={Home} />

          <Tab.Screen name="CadastraFilme" component={CadastraFilme} />

          <Tab.Screen name="EditarFilme" component={EditarFilme} />

          <Tab.Screen name="ExibirFilme" component={ExibirFilme} />

          <Tab.Screen name="PesquisaFilme" component={PesquisaFilme} />
        </Stack.Navigator>
      </NavigationContainer>

    </SafeAreaProvider>
  );
}

const styles = StyleSheet.create({
  androidSafeArea: {
    flex: 1,
    paddingTop: Platform.OS === 'android' ? getStatusBarHeight() : 0,
    marginTop: 10
  },
  container: {
    flex: 1,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "center",
  },
});

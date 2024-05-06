# Aula 04
<<<<<<< HEAD
## Trabalhando com Navegação - Tab Navigation 
=======
## Trabalhando com Navegação
>>>>>>> 1f2e5e8b38e14657527fd84becf5851b9a81ce0e

- React Navigation é uma das soluções existentes mais famosas e recomendadas pelo Facebook para roteamento e navegação entre telas no React Native. A famosa biblioteca Javascript, React Native, não apresenta mecanismos de navegação de forma nativa. Por isso, para executar essas ações da melhor forma possível, surgiu a biblioteca React Navigation.

### Docs React Navigation

- [React Navigation](https://reactnavigation.org/docs/getting-started/) - 

<<<<<<< HEAD
### Docs Tab Navigator:  

-  [Botton Tab Navigator](https://reactnavigation.org/docs/bottom-tab-navigator)

### Passo 01:  
- Instalar pelo terminal na aula **appAula4Pt3**:

``` bash
    npm install @react-navigation/bottom-tabs
```
### Passo 02:  
- No arquivo **App.js**: 

- Incluir o import do **createBottomTabNavigator**:
```javascript
    import { createBottomTabNavigator } from '@react-navigation/bottom-tabs'
```
- Em seguida alterar a variável que cria o tipo **Stack** para o tipo **Tab**:  
De:  
``` javascript
    const Stack = createNativeStackNavigator();
```

Para:  
``` javascript
    const Tab = createBottomTabNavigator();
```

- Alterar todos os componetes do tipo **Stack.Screen** para o exemplo:

```javascript
    <Tab.Screen
        //Manter o restante do código como está
    />
```
=======
### Passo 01:   
- Instalar as bibliotecas:  
```bash
npm install @react-navigation/drawer  
npm install react-native-gesture-handler react-native-reanimated  
```

### Passo 02:  
- Acessar a o endereço:  

- [React Native Reanimated](https://docs.swmansion.com/react-native-reanimated/docs/fundamentals/getting-started)  

Navegar até a **Installation** e localizar **Step 2**, copiar o plugin e colar no arquivo babel.config.js localizado em seu projeto:  

```javascript
plugins: [
    ...
    'react-native-reanimated/plugin',
],
```

### Passo 03:  
- Importar no App.js para finalizar a instalação de react-native-gesture-handler, adicione o import no topo (certifique-se de que está no topo e não há mais nada antes dele):
```javascript
import 'react-native-gesture-handler';
```
### Passo 04:  
- Em **routes/index.js** 

- Apagar todo conteúdo da função **Routes()**, devendo ficar dessa forma:  
```javascript
export default function Routes() {
  return (
  
  )
}
```
- Apagar o import:  
```javascript
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs'
```
- Apagar a variável:  
```javascript
const Tab = createBottomTabNavigator();
```

### Passo 05:  

- Realizar o import do Drawer no **routes/index.js** :
```javascript
import { createDrawerNavigator } from "@react-navigation/drawer";
```

- Realizar a criação da const:
```javascript
const Drawer=createDrawerNavigator();
```

### Passo 06:  

- Criar uma pasta chamada **components** na raiz da aplicação
- Dentro da pasta **components** criar um arquivo **CustomDrawer.js**, neste arquivo digitar o seguinte código:

```javascript
import {View, Text} from 'react-native'

export default function CustomDrawer(){
    return(
        <View>
            <Text>TESTE</Text>
        </View>
    )
}
```
>>>>>>> 1f2e5e8b38e14657527fd84becf5851b9a81ce0e

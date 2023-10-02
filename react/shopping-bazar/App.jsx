import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import React from "react";
import { Alert, Platform, Text, TouchableOpacity } from "react-native";
import Checkout from "./src/checkout";
import Home from "./src/home";
import Login from "./src/login";
import ProductDetail from "./src/product-detail";
import { appStyles as styles } from "./styles/styles";

// Navigation system for mobile and web with navigation history.
const Stack = createNativeStackNavigator();

export default function App() {
  const apiInfo = () => {
    Alert.alert("Fake API", "https://fakestoreapi.com", [{
      text: "Ok",
      onPress: () => {},
    }]);
  };

  return (
    <NavigationContainer>
      <Stack.Navigator
        screenOptions={{
          headerLargeTitle: Platform.OS === "ios",
          headerTitleStyle: { fontWeight: "bold" },
          headerStyle: { backgroundColor: "pink" },
          headerBlurEffect: "systemChromeMaterial",
        }}
      >
        <Stack.Screen
          name="Login"
          component={Login}
          options={{
            title: "Login",
            headerBackVisible: false,
            headerRight: () => (
              <TouchableOpacity
                style={{ marginHorizontal: 16 }}
                onPress={apiInfo}
              >
                <Text style={styles.appBarButton}>Notice</Text>
              </TouchableOpacity>
            ),
          }}
        />
        <Stack.Screen
          name="Home"
          component={Home}
          options={({ navigation, route }) => ({
            title: "Shopping Bazar",
            headerBackVisible: false,
            headerRight: () => (
              <TouchableOpacity
                onPress={() => {
                  navigation.navigate("CartDetail");
                }}
              >
                <Text style={styles.appBarButton}>Cart</Text>
              </TouchableOpacity>
            ),
          })}
        />
        <Stack.Screen
          name="ProductDetail"
          component={ProductDetail}
          options={{ title: "Product Detail" }}
        />
        <Stack.Screen
          name="CartDetail"
          component={Checkout}
          options={({ navigation, route }) => ({
            title: "Checkout",
            headerRight: () => (
              <TouchableOpacity
                onPress={navigation.popToTop}
              >
                <Text style={styles.appBarButton}>Logout</Text>
              </TouchableOpacity>
            ),
          })}
        />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

import React, { useState } from "react";
import {
  Image,
  SafeAreaView,
  Text,
  TextInput,
  TouchableOpacity,
  View,
} from "react-native";
import { loginStyles as styles } from "../styles/styles";

export default function Login({ navigation, route }) {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");

  /**
   * You can use any of the users' username and password
   * available in users API to get token.
   * any other usernames return error.
   *
   * returns:
   * {
   *    token: "eyJhbGciOiJIUzI1NiIsInR"
   * }
   *
   * API docs: https://fakestoreapi.com/docs#:~:text=Login-,User%20login,-fetch(%27https%3A//fakestoreapi
   */
  const authorize = async () => {
    try {
      // await fetch('https://fakestoreapi.com/auth/login', {
      //   method: 'POST',
      //   body: JSON.stringify({
      //     username: "mor_2314",
      //     password: "83r5^_"
      //   })
      // }).then((response) => {
      //   console.log(response.json());
      // });
    } catch (e) {
      console.log(e);
    } finally {
      navigation.navigate("Home");
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.body}>
        <Image style={styles.logo} source={require("../assets/icon.png")} />
        <TextInput
          value={username}
          style={styles.textField}
          clearButtonMode="always"
          placeholderTextColor="grey"
          placeholder="Enter username"
          onChangeText={(value) => {
            setUsername(value);
          }}
        />
        <TextInput
          value={password}
          style={styles.textField}
          clearButtonMode="always"
          placeholderTextColor="grey"
          placeholder="Enter password"
          onChangeText={(value) => {
            setPassword(value);
          }}
        />
        <TouchableOpacity style={styles.loginButton} onPress={authorize}>
          <Text style={{ fontWeight: "bold" }}>Login</Text>
        </TouchableOpacity>
        <Text style={styles.registerLink}>
          Don't have an account yet? Sign Up
        </Text>
      </View>
    </SafeAreaView>
  );
}

import React, { useState } from "react";
import {
  Image,
  SafeAreaView,
  StyleSheet,
  Text,
  TextInput,
  TouchableOpacity,
  View,
} from "react-native";

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
          onChangeText={setUsername}
        />
        <TextInput
          value={password}
          style={styles.textField}
          clearButtonMode="always"
          placeholderTextColor="grey"
          placeholder="Enter password"
          onChangeText={setPassword}
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

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "lavenderblush",
  },
  body: {
    flex: 1,
    padding: 16,
  },
  logo: {
    height: 300,
    width: "100%",
    borderRadius: 10,
    marginBottom: 70,
    resizeMode: "contain",
  },
  textField: {
    height: 40,
    padding: 10,
    borderWidth: 1,
    borderRadius: 5,
    marginVertical: 5,
    borderColor: "grey",
  },
  loginButton: {
    height: 40,
    borderRadius: 5,
    marginVertical: 5,
    alignItems: "center",
    backgroundColor: "pink",
    justifyContent: "center",
  },
  registerLink: {
    color: "blue",
    marginTop: 30,
    lineHeight: 50,
    alignSelf: "center",
  },
});

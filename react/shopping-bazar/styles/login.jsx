import { StyleSheet } from "react-native";

export const loginStyles = StyleSheet.create({
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

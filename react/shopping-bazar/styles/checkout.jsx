import { StyleSheet } from "react-native";

export const checkoutStyles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: "center",
    backgroundColor: "lavenderblush",
  },
  date: {
    padding: 10,
    borderWidth: 1,
    borderRadius: 5,
    marginVertical: 5,
    borderColor: "gray",
    backgroundColor: "aliceblue",
  },
  list: {
    flex: 1,
    margin: 16,
    marginHorizontal: 10,
    paddingHorizontal: 5,
  },
  buttonBar: {
    flexDirection: "row",
    justifyContent: "space-between",
  },
  checkoutButton: {
    flex: 1,
    height: 40,
    maxWidth: "48%",
    borderRadius: 5,
    marginVertical: 10,
    alignItems: "center",
    justifyContent: "center",
    backgroundColor: "palegreen",
  },
  clearButton: {
    backgroundColor: "lightsalmon",
  },
});

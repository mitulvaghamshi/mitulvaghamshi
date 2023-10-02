import { StyleSheet } from "react-native";

export const homeStyles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 5,
    backgroundColor: "lavenderblush",
  },
  body: {
    flex: 1,
    marginTop: 10,
  },
  searchBox: {
    height: 40,
    padding: 10,
    borderWidth: 1,
    borderRadius: 5,
    borderColor: "grey",
    marginHorizontal: 15,
    marginVertical: 5,
  },
  list: {
    flex: 1,
    marginTop: 20,
    marginHorizontal: 10,
    paddingHorizontal: 5,
  },
  row: {
    flexWrap: "wrap",
    flexDirection: "row",
    marginHorizontal: 10,
    justifyContent: "space-between",
  },
  button: {
    flex: 1,
    margin: 5,
    padding: 5,
    minWidth: "40%",
    borderRadius: 5,
    alignItems: "center",
    backgroundColor: "pink",
  },
  selected: {
    backgroundColor: "black",
  },
  buttonLabel: {
    fontWeight: "500",
    textTransform: "capitalize",
  },
  selectedLabel: {
    color: "white",
    fontWeight: "700",
  },
});

import { StyleSheet } from "react-native";

export const listItemStyles = StyleSheet.create({
  item: {
    padding: 10,
    borderWidth: 1,
    borderRadius: 5,
    marginVertical: 5,
    borderColor: "gray",
    flexDirection: "row",
    backgroundColor: "ghostwhite",
    justifyContent: "space-between",
  },
  image: {
    width: "30%",
    borderRadius: 5,
    resizeMode: "contain",
  },
  labelContainer: {
    width: "65%",
    flexDirection: "column",
    justifyContent: "space-between",
  },
  title: {
    display: "flex",
    fontWeight: "bold",
  },
  rating: {
    color: "coral",
    fontWeight: "800",
  },
  review: {
    color: "grey",
    fontWeight: "800",
  },
  price: {
    color: "green",
    fontWeight: "800",
  },
  addButton: {
    height: 30,
    color: "black",
    borderRadius: 5,
    alignItems: "center",
    justifyContent: "center",
    backgroundColor: "peachpuff",
  },
});

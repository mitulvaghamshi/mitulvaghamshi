import { StyleSheet } from "react-native";

export const productDetailStyles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 16,
    backgroundColor: "lavenderblush",
  },
  image: {
    width: "100%",
    borderWidth: 1,
    aspectRatio: 1,
    marginBottom: 10,
    borderRadius: 10,
    borderColor: "gray",
    resizeMode: "contain",
  },
  item: {
    borderWidth: 1,
    borderRadius: 5,
    marginVertical: 5,
    borderColor: "gray",
    backgroundColor: "white",
  },
  labelContainer: {
    display: "flex",
    flexDirection: "row",
    justifyContent: "space-between",
  },
  title: {
    padding: 5,
    fontSize: 18,
  },
  rating: {
    padding: 5,
    color: "coral",
    fontWeight: "800",
  },
  review: {
    padding: 5,
    color: "grey",
    fontWeight: "800",
  },
  price: {
    padding: 5,
    color: "green",
    fontWeight: "800",
  },
  removeButton: {
    height: 40,
    borderRadius: 5,
    marginVertical: 10,
    alignItems: "center",
    justifyContent: "center",
    backgroundColor: "lightsalmon",
  },
});

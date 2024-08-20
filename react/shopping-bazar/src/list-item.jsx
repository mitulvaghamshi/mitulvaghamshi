import React from "react";
import {
  Alert,
  Image,
  Platform,
  StyleSheet,
  Text,
  TouchableHighlight,
  View,
} from "react-native";

export default function ListItem(props) {
  /**
   * Fake API: No product is added in the database,
   * return with random non-existing product ID.
   */
  const addToCart = async () => {
    const response = await fetch("https://fakestoreapi.com/carts", {
      method: "POST",
      body: JSON.stringify({
        userId: 5,
        date: "2020-02-03",
        products: [
          { productId: 5, quantity: 1 },
          { productId: 1, quantity: 5 },
        ],
      }),
    });
    const result = await response.json();
    if (result) {
      showItemAddedAlert();
    }
  };

  const showItemAddedAlert = () => {
    if (Platform.OS === "web") {
      alert(`${props.product.title} added successfully...!`);
    } else {
      Alert.alert(
        "Added to Cart",
        `${props.product.title} added successfully...!`,
        [{ text: "Ok", onPress: () => {} }],
      );
    }
  };

  return (
    <View key={props.product.id} style={styles.item}>
      {Platform.OS === "web"
        ? (
          <img
            src={props.product.image}
            style={{
              margin: 3,
              width: "20%",
              resizeMode: "contain",
            }}
            alt="product image"
          />
        )
        : (
          <Image style={styles.image} source={{ uri: props.product.image }}>
          </Image>
        )}
      <View style={styles.labelContainer}>
        <Text style={styles.title} numberOfLines={2}>
          {props.product.title}
        </Text>
        {props.isCart
          ? (
            <View>
              <Text style={styles.rating}>
                Quantity: ${props.product.quantity}
              </Text>
              <Text style={styles.price}>
                Total Amount: ${props.product.price * props.product.quantity}
              </Text>
            </View>
          )
          : (
            <View>
              <Text style={styles.rating}>
                Ratings: {props.product.rating.rate}★
              </Text>
              <Text style={styles.review}>
                Reviews: {props.product.rating.count}
              </Text>
              <Text style={styles.price}>
                ${props.product.price}
              </Text>
              <TouchableHighlight style={styles.addButton} onPress={addToCart}>
                <Text style={{ fontWeight: "bold" }}>Add to Cart</Text>
              </TouchableHighlight>
            </View>
          )}
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
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

import React from "react";
import {
  Alert,
  Image,
  Platform,
  Text,
  TouchableHighlight,
  View,
} from "react-native";
import { listItemStyles as styles } from "../styles/styles";

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
                Quantity: {props.product.quantity} * (${props.product.price})
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

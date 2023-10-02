import React from "react";
import {
  Alert,
  Image,
  Platform,
  Text,
  TouchableHighlight,
  View,
} from "react-native";
import { productDetailStyles as styles } from "../styles/styles";

export default function ProductDetail({ navigation, route }) {
  const product = route.params.product;

  const confirmRemove = () => {
    if (Platform.OS === "web") {
      alert("Item removed successfully...!");
      navigation.pop();
    } else {
      Alert.alert(
        "Remove Item?",
        "Are you want to remove this item from cart?",
        [
          { text: "Cancel", onPress: () => {} },
          {
            text: "Yes",
            style: "destructive",
            onPress: () => {
              navigation.pop();
            },
          },
        ],
      );
    }
  };

  return (
    <View style={styles.container}>
      {Platform.OS === "web"
        ? (
          <img
            src={product.image}
            alt="logo"
            style={{
              margin: 10,
              width: "50%",
              alignSelf: "center",
            }}
          />
        )
        : (
          <Image style={styles.image} source={{ uri: product.image }}>
          </Image>
        )}
      <View style={styles.item}>
        <Text style={styles.title}>
          {product.title}
        </Text>
        <View style={styles.labelContainer}>
          <Text style={styles.rating}>
            Ratings: {product.rating.rate}★
          </Text>
          <Text style={styles.review}>
            Reviews: {product.rating.count}
          </Text>
          <Text style={styles.price}>
            ${product.price}
          </Text>
        </View>
      </View>
      <View style={styles.item}>
        <View style={styles.labelContainer}>
          <Text style={styles.rating}>
            Items in Cart: 10
          </Text>
          <Text style={styles.price}>
            Total: {10 * product.price}
          </Text>
        </View>
      </View>
      <TouchableHighlight style={styles.removeButton} onPress={confirmRemove}>
        <Text style={{ fontWeight: "bold" }}>Remove</Text>
      </TouchableHighlight>
    </View>
  );
}

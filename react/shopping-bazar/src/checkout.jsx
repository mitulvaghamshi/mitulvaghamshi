import React, { useEffect, useRef, useState } from "react";
import {
  ActivityIndicator,
  Alert,
  FlatList,
  Platform,
  StyleSheet,
  Text,
  TouchableHighlight,
  View,
} from "react-native";
import CartItem from "./cart-item";

export default function Checkout({ navigation, route }) {
  const [cartItems, setCartItems] = useState([]);
  const [loding, setLoading] = useState(true);

  /**
   * Warning: Can't perform a React state update on an unmounted component.
   *
   * Example event: If user logout while application is still fetching the data,
   * this resolved by watching component's mounting state.
   *
   * This is a no-op, but it indicates a memory leak in your application.
   * To fix, cancel all subscriptions and asynchronous tasks in a useEffect cleanup function.
   */
  const mounted = useRef(true);

  /**
   * The API is completely stateless, provides static data
   * by simulating fake CRUD operations.
   * Application does not contain actual user, therefore the same user
   * with the ID of 1 is used to retrieve cart information.
   */
  const getCart = async () => {
    try {
      const responce = await fetch("https://fakestoreapi.com/carts/user/1");
      const result = await responce.json();
      // Do not update state if component is unmounted...
      if (mounted.current) {
        setCartItems(result);
      }
    } catch (e) {
      console.log(e);
    } finally {
      setLoading(false);
    }
  };

  /**
   * Removing cart does not remove anything from database,
   * the request is performed (simulated) at backend by returning fake response.
   *
   * @param {*} id to remove a cart
   */
  const removeCart = async (id) => {
    try {
      const responce = await fetch(`https://fakestoreapi.com/carts/${id}`);
      // nothing to do with the result.
      const _ = await responce.json();
    } catch (e) {
      console.log(e);
    }
  };

  const showCheckoutAlert = () => {
    if (Platform.OS === "web") {
      alert(
        "Thank you for shopping with us! Please tell us about your experience by providing a review...",
      );
    } else {
      Alert.alert(
        "Thank you for shopping with us!",
        "Please tell us about your experience by providing a review...",
        [{ text: "Ok", onPress: () => {} }],
      );
    }
  };

  const showRemoveAlert = (id) => {
    if (Platform.OS === "web") {
      alert("CArt deleted successfully...!");
      navigation.pop();
    } else {
      Alert.alert(
        "Delete cart?",
        "Are you want to remove all items from cart?",
        [{
          text: "Cancel",
          onPress: () => {},
        }, {
          text: "Yes",
          style: "destructive",
          onPress: () => {
            removeCart(id);
            navigation.pop();
          },
        }],
      );
    }
  };

  useEffect(() => {
    getCart();
    // return cleanup function to mark component unmounted
    // when user use back navigation or try to logout.
    return () => {
      mounted.current = false;
    };
  }, []);

  return (
    <View style={styles.container}>
      {loding ? <ActivityIndicator /> : (
        <FlatList
          data={cartItems}
          style={styles.list}
          keyExtractor={(item) => item.id}
          renderItem={({ item }) => {
            return (
              <View key={item.id}>
                <Text style={styles.date}>
                  Cart saved on: {new Date(item.date).toDateString()}
                </Text>
                <CartItem item={item} />
                <View style={styles.buttonBar}>
                  <TouchableHighlight
                    style={styles.checkoutButton}
                    onPress={showCheckoutAlert}
                  >
                    <Text style={{ color: "black" }}>Checkout</Text>
                  </TouchableHighlight>
                  <TouchableHighlight
                    style={[styles.checkoutButton, styles.clearButton]}
                    onPress={() => {
                      showRemoveAlert(item.id);
                    }}
                  >
                    <Text style={{ color: "black" }}>Clear All</Text>
                  </TouchableHighlight>
                </View>
              </View>
            );
          }}
        />
      )}
    </View>
  );
}

const styles = StyleSheet.create({
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

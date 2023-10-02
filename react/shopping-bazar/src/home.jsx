import React, { useEffect, useState } from "react";
import {
  ActivityIndicator,
  FlatList,
  SafeAreaView,
  Text,
  TextInput,
  TouchableOpacity,
  View,
} from "react-native";
import ListItem from "./list-item";
import { homeStyles as styles } from "../styles/styles";

export default function Home({ navigation }) {
  const [productList, setProductList] = useState([]);
  const [categoryList, setCategoryList] = useState([]);

  const [searchQuery, setSearchQuery] = useState("");
  const [loding, setLoading] = useState(true);
  const [category, setCategory] = useState("All Products");

  useEffect(() => {
    // Get all the categories (4)
    (async () => {
      try {
        const responce = await fetch(
          "https://fakestoreapi.com/products/categories",
        );
        const result = await responce.json();
        // Include option to allow all products (default).
        setCategoryList(["All Products", ...result]);
      } catch (e) {
        console.log(e);
      }
    })();
  }, []);

  useEffect(() => {
    /**
     * JSON Parse error: Unrecognized token'<'
     * Using `response.json()` in the event of 404 or 500 error.
     * Stack Overflow: https://is.gd/9ITO6V
     */
    (async () => {
      try {
        const categoryFilter = category === "All Products"
          ? ""
          : "category/" + category;
        const responce = await fetch(
          `https://fakestoreapi.com/products/${categoryFilter}`,
        );
        const result = await responce.json();
        setProductList(result);
      } catch (e) {
        console.log(e);
      } finally {
        setLoading(false);
      }
    })();
  }, [category]);

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.body}>
        <TextInput
          value={searchQuery}
          style={styles.searchBox}
          onChangeText={setSearchQuery}
          placeholder="Search product..."
          placeholderTextColor="grey"
          clearButtonMode="always"
        />
        <View style={styles.row} horizontal={true}>
          {categoryList.map((value) => (
            <TouchableOpacity
              key={value}
              onPress={() => {
                if (category !== value) {
                  setLoading(true);
                  setCategory(value);
                }
              }}
              style={[styles.button, category === value && styles.selected]}
            >
              <Text
                style={[
                  styles.buttonLabel,
                  category === value && styles.selectedLabel,
                ]}
              >
                {value}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
        {loding ? <ActivityIndicator /> : (
          <FlatList
            data={productList}
            style={styles.list}
            keyExtractor={({ id }, index) => id}
            renderItem={({ item }) => (
              <TouchableOpacity
                onPress={() => {
                  navigation.navigate("ProductDetail", { "product": item });
                }}
              >
                <ListItem isCart={false} product={item} />
              </TouchableOpacity>
            )}
          />
        )}
      </View>
    </SafeAreaView>
  );
}

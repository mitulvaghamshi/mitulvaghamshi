import React, { useEffect, useState } from "react";
import {
  ActivityIndicator,
  FlatList,
  SafeAreaView,
  StyleSheet,
  Text,
  TextInput,
  TouchableOpacity,
  View,
} from "react-native";
import ListItem from "./list-item";

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
     * Stack Overflow: https://stackoverflow.com/questions/50837479/json-parse-error-unrecognized-token-react-native
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

const styles = StyleSheet.create({
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

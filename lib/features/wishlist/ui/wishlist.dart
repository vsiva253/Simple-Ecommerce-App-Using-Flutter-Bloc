import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  List<String> favoriteProducts = [];

  @override
  void initState() {
    super.initState();
    // Load the list of favorite products from local storage
    loadFavoriteProducts();
  }

  Future<void> loadFavoriteProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final savedFavorites = prefs.getStringList('favorite_products') ?? [];

    setState(() {
      favoriteProducts = savedFavorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: favoriteProducts.isEmpty
          ? Center(
              child: Text('Your wishlist is empty.'),
            )
          : ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                // You can load and display details of each favorite product here
                // Example: ProductTileWidget(productID: favoriteProducts[index])
                return ListTile(
                  title: Text('Product ID: ${favoriteProducts[index]}'),
                  // Add more details or actions as needed
                );
              },
            ),
    );
  }
}

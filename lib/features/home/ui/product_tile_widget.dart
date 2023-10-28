import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/home_bloc.dart';
import '../models/home_product_data_model.dart';

class ProductTileWidget extends StatefulWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;

  ProductTileWidget({
    Key? key,
    required this.productDataModel,
    required this.homeBloc,
  }) : super(key: key);

  @override
  _ProductTileWidgetState createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<ProductTileWidget> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    // Check if the current product is in the list of favorite products
    loadFavoriteStatus();
  }

  Future<void> loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteProducts = prefs.getStringList('favorite_products') ?? [];

    setState(() {
      isFavorite = favoriteProducts.contains(widget.productDataModel.id);
    });
  }

  Future<void> toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteProducts = prefs.getStringList('favorite_products') ?? [];

    if (isFavorite) {
      // Remove the product from the favorites
      favoriteProducts.remove(widget.productDataModel.id);
    } else {
      // Add the product to the favorites
      favoriteProducts.add(widget.productDataModel.id);
    }

    // Save the updated list of favorite products
    await prefs.setStringList('favorite_products', favoriteProducts);

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.productDataModel.imageUrl),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.productDataModel.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            widget.productDataModel.description,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$" + widget.productDataModel.price.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: toggleFavorite,
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.homeBloc.add(HomeProductCartButtonClickedEvent(
                        clickedProduct: widget.productDataModel,
                      ));
                    },
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

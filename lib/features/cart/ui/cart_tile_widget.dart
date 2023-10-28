import 'package:bikerent/features/cart/bloc/cart_bloc.dart';
import 'package:bikerent/features/home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartTileWidget extends StatefulWidget {
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;

  CartTileWidget({
    Key? key,
    required this.productDataModel,
    required this.cartBloc,
  }) : super(key: key);

  @override
  _CartTileWidgetState createState() => _CartTileWidgetState();
}

class _CartTileWidgetState extends State<CartTileWidget> {
  bool isInCart = true;
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    // Check if the current product is in the cart
    loadCartStatus();
  }

  Future<void> loadCartStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final cartProducts = prefs.getStringList('cart_products') ?? [];

    setState(() {
      isInCart = cartProducts.contains(widget.productDataModel.id);
      if (isInCart) {
        // Calculate the total price of items in the cart
        calculateTotalPrice(prefs, cartProducts);
      }
    });
  }

  Future<void> toggleCartStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final cartProducts = prefs.getStringList('cart_products') ?? [];

    if (isInCart) {
      // Remove the product from the cart
      cartProducts.remove(widget.productDataModel.id);
    } else {
      // Add the product to the cart
      cartProducts.add(widget.productDataModel.id);
    }

    // Save the updated list of cart products
    await prefs.setStringList('cart_products', cartProducts);

    setState(() {
      isInCart = !isInCart;
      // Calculate the total price of items in the cart
      calculateTotalPrice(prefs, cartProducts);
    });
  }

  Future<void> calculateTotalPrice(
      SharedPreferences prefs, List<String> cartProducts) async {
    double total = 0.0;
    for (var productId in cartProducts) {
      // Fetch the product price based on the ID and add it to the total
      final price = await fetchProductPrice(productId);
      total += price;
    }

    setState(() {
      totalPrice = total;
    });
  }

  Future<double> fetchProductPrice(String productId) async {
    // Implement the logic to fetch the price of a product based on its ID
    // You may need to make an API call or use local data
    // For demonstration, let's assume a fixed price for each product
    return 19.99; // Replace with your actual logic
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
                    onPressed: toggleCartStatus,
                    icon: Icon(
                      isInCart
                          ? Icons.shopping_cart
                          : Icons.shopping_cart_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$${totalPrice.toStringAsFixed(2)}', // Display total price
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Colors.grey.shade200,
                  ),
                ),
                onPressed: () {
                  // Add the logic to proceed with payment here
                },
                child: Text(
                  'Pay',
                  style: TextStyle(
                    color: Colors.pink,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

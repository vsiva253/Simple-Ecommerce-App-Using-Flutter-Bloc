# BuyFromUs - E-commerce App

BuyFromUs is a simple Flutter e-commerce app that allows users to view and manage their shopping cart and wishlist. This app demonstrates the use of Flutter, the BLoC (Business Logic Component) pattern, and shared preferences for storing user data.

## Features

- View a list of products with details.
- Add and remove products from the shopping cart.
- Add and remove products from the wishlist.
- Calculate the total price of items in the shopping cart.
- Proceed with the payment for the items in the shopping cart.

## Project Structure

The project is structured into the following parts:

1. **lib:** Contains the main codebase for the application.
   - **features:**
     - **cart:** Manages the shopping cart functionality.
     - **home:** Handles the main home screen and product listing.
     - **wishlist:** Manages the wishlist functionality.
   - **models:** Contains data models for the application.
   - **ui:** Includes widgets for displaying cart items, product tiles, and the main app screens.
   - **bloc:** Contains BLoC (Business Logic Component) classes for cart and home screens.
   - **main.dart:** Entry point of the application.

## Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/BuyFromUs.git

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../modules/Cart/cubit/cart_cubit.dart'; // Import the CartCubit

class CustomAppBar extends StatelessWidget {
  final Size screenSize;
  final PersistentTabController navController; // Accept PersistentTabController

  const CustomAppBar(
      {super.key, required this.screenSize, required this.navController});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find Your',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Dream Furniture',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(
            children: [
              IconButton(
                onPressed: () {
                  // Set the tab index directly to Cart (index 2 in this example)
                  navController.jumpToTab(2); // Index for Cart tab
                },
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
              // Badge for cart items count
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state is CartLoadedState && state.cartItems.isNotEmpty) {
                    return Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          state.totalQuantity.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox(); // Return empty if cart is empty
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../shared/app_string.dart';

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
              AppString.findYour(context),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              AppString.dreamFurniture(context),
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
          child: IconButton(
              onPressed: () {
                // Set the tab index directly to Cart (index 2 in this example)
                navController.jumpToTab(2); // Index for Cart tab
              },
              icon: const Icon(Icons.shopping_cart_outlined)),
        ),
      ],
    );
  }
}

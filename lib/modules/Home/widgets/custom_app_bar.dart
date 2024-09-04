import 'package:flutter/material.dart';

import '../../../shared/app_string.dart';
import '../../Cart/cart_screen.dart';

class CustomAppBar extends StatelessWidget {
  final Size screenSize;

  const CustomAppBar({super.key, required this.screenSize});

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart_outlined)),
        )
        // CircleAvatar(
        //   radius: 25,
        //   backgroundImage: AssetImage(
        //       AppString.profile), // Replace with your image asset
        // ),
      ],
    );
  }
}

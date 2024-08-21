import 'package:flutter/material.dart';

import '../../../shared/app_string.dart';

class CustomAppBar extends StatelessWidget {
  final Size screenSize;

  const CustomAppBar({super.key, required this.screenSize});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppString.findYour,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              AppString.dreamFurniture,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(AppString.profile), // Replace with your image asset
        ),
      ],
    );
  }
}

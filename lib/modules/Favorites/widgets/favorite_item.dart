import 'package:bella_app/models/favorite_item_model.dart';
import 'package:flutter/material.dart';
import '../../../shared/custom_snackbar.dart'; // Import the CustomSnackbar
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class FavoriteItem extends StatelessWidget {
  final FavoriteItemModel item;
  final double itemHeight;

  const FavoriteItem({
    super.key,
    required this.item,
    required this.itemHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Image.asset(
            item.imageUrl,
            width: itemHeight,
            height: itemHeight,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.cancel_outlined),
                onPressed: () {
                  // Remove from favorites logic
                },
              ),
              const SizedBox(height: 8.0), // Adjust the height as needed
              IconButton(
                icon: Icon(
                  item.isInCart
                      ? Icons.shopping_bag
                      : Icons.shopping_bag_outlined,
                  color: item.isInCart ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  // Add your add-to-cart logic

                  // Show a snackbar message using CustomSnackbar
                  CustomSnackbar.show(
                    context,
                    title: 'Success',
                    message: 'Product added to the cart!',
                    contentType: ContentType.success,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

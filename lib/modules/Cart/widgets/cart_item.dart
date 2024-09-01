import 'package:bella_app/models/cart_item_model.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onRemove;
  final void Function(dynamic) onQuantityChanged;

  const CartItem({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            item.imageUrl,
            width: 80,
            height: 80,
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
                const SizedBox(height: 8.0),
                Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        onQuantityChanged(false);
                      },
                    ),
                    Text(
                      item.quantity.toString().padLeft(2, '0'),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () {
                        onQuantityChanged(true);
                      },
                    ),
                  ],
                ),
                const Divider()
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}

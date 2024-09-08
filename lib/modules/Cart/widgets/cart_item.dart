// cart_item.dart
import 'package:bella_app/models/cart_item_model.dart';
import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  final CartItemModel item;
  final VoidCallback onRemove;
  final void Function(bool isIncrement) onQuantityChanged;

  const CartItem({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onQuantityChanged,
  });

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int currentQuantity;

  @override
  void initState() {
    super.initState();
    currentQuantity =
        widget.item.quantity; // Initialize with the item's quantity
  }

  void _incrementQuantity() {
    setState(() {
      currentQuantity++;
    });
    widget.onQuantityChanged(true);
  }

  void _decrementQuantity() {
    if (currentQuantity > 1) {
      setState(() {
        currentQuantity--;
      });
      widget.onQuantityChanged(false);
    } else {
      // Optionally remove item if quantity reaches 0
      widget.onRemove();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.item.imageUrl,
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
                  widget.item.title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '\$${widget.item.price.toStringAsFixed(2)}',
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
                      onPressed: _decrementQuantity,
                    ),
                    Text(
                      currentQuantity.toString().padLeft(2, '0'),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: _incrementQuantity,
                    ),
                  ],
                ),
                const Divider(),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: widget.onRemove,
          ),
        ],
      ),
    );
  }
}

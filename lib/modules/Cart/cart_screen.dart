import 'package:bella_app/shared/app_string.dart';
import 'package:flutter/material.dart';
import '../../models/cart_item_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _promoCodeController = TextEditingController();
  double _totalAmount = 95.00;
  double _discount = 0.0;

  final List<CartItemModel> _cartItems = [
    CartItemModel(
      imageUrl: AppString.chair,
      title: 'Minimal Stand',
      price: 25.00,
    ),
    CartItemModel(
      imageUrl: AppString.table,
      title: 'Coffee Table',
      price: 20.00,
    ),
    CartItemModel(
      imageUrl: AppString.chair,
      title: 'Minimal Desk',
      price: 50.00,
    ),
  ];

  void _removeItem(int index) {
    setState(() {
      _totalAmount -= _cartItems[index].totalPrice;
      _cartItems.removeAt(index);
    });
  }

  void _applyPromoCode() {
    if (_promoCodeController.text == 'ysf') {
      setState(() {
        _discount = 0.10;
      });
    } else {
      setState(() {
        _discount = 0.0;
      });
    }
  }

  void _updateTotalAmount() {
    _totalAmount = _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  @override
  Widget build(BuildContext context) {
    double finalAmount = _totalAmount - (_totalAmount * _discount);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.myCart),
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              // Cart Items List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _cartItems.length,
                  itemBuilder: (context, index) {
                    return CartItem(
                      item: _cartItems[index],
                      onRemove: () => _removeItem(index),
                      onQuantityChanged: () {
                        setState(() {
                          _updateTotalAmount();
                        });
                      },
                    );
                  },
                ),
              ),
              // Promo Code Input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _promoCodeController,
                        decoration: InputDecoration(
                          hintText: AppString.promoCode,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    IconButton(
                      onPressed: _applyPromoCode,
                      icon: const Icon(Icons.arrow_forward),
                      color: Colors.white,
                      iconSize: 30,
                      padding: const EdgeInsets.all(10.0),
                      constraints: const BoxConstraints(),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Total Amount and Checkout Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppString.total,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${finalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        // Checkout logic
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        AppString.checkOut,
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onRemove;
  final VoidCallback onQuantityChanged;

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
                        item.decreaseQuantity();
                        onQuantityChanged();
                      },
                    ),
                    Text(
                      item.quantity.toString().padLeft(2, '0'),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () {
                        item.increaseQuantity();
                        onQuantityChanged();
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

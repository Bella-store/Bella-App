// cart_item_model.dart

class CartItemModel {
  final String imageUrl;
  final String title;
  final double price;
  int quantity;

  CartItemModel({
    required this.imageUrl,
    required this.title,
    required this.price,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;

  void increaseQuantity() {
    quantity++;
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}

class CartItemModel {
  final String id;
  final String imageUrl;
  final String title;
  final double price;
  int quantity;

  CartItemModel({
    required this.id,
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

  // Convert CartItemModel to a Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'price': price,
      'quantity': quantity,
    };
  }

  // Create CartItemModel from a Firestore map
  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      title: map['title'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity'] ?? 1,
    );
  }
}

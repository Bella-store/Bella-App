class Product {
  final String id;
  final String imageUrl;
  final String title;
  final double price;
  final int quantity;
  final String description;
  final String category;

  Product({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.quantity,
    required this.description,
    required this.category,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      imageUrl: map['imageUrl'],
      title: map['title'],
      price: map['price'],
      quantity: map['quantity'],
      description: map['description'],
      category: map['category'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'price': price,
      'quantity': quantity,
      'description': description,
      'category': category,
    };
  }
}

class FavoriteItemModel {
  final String id;
  final String imageUrl;
  final String title;
  final double price;
  bool isFavorite;
  bool isInCart;

  FavoriteItemModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.isFavorite = false,
    this.isInCart = false,
  });
}

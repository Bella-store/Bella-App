import 'package:flutter/material.dart';

import '../../models/favorite_item_model.dart';
import '../../shared/app_string.dart';

class FavoritesScreen extends StatelessWidget {
  final List<FavoriteItemModel> favoriteItems = [
    FavoriteItemModel(
        imageUrl: AppString.chair, title: 'Coffee Table', price: 50.00),
    FavoriteItemModel(
        imageUrl: AppString.table, title: 'Coffee Chair', price: 20.00),
    FavoriteItemModel(
        imageUrl: AppString.chair, title: 'Minimal Stand', price: 25.00),
    FavoriteItemModel(
        imageUrl: AppString.table, title: 'Minimal Desk', price: 50.00),
    FavoriteItemModel(
        imageUrl: AppString.chair, title: 'Minimal Lamp', price: 12.00),
  ];

  FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double itemHeight = constraints.maxHeight * 0.1;
          double itemWidth = constraints.maxWidth;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: favoriteItems.length,
                  itemBuilder: (context, index) {
                    return FavoriteItem(
                      item: favoriteItems[index],
                      itemHeight: itemHeight,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(itemWidth, 50),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    // Add all to cart logic here
                  },
                  child: const Text(
                    'Add all to my cart',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

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
                  // Add to cart logic
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

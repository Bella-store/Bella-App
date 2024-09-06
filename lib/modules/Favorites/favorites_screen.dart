import 'package:bella_app/models/favorite_item_model.dart';
import 'package:flutter/material.dart';
import '../../models/favorite_item_model.dart';
import '../../shared/app_color.dart';
import '../../shared/app_string.dart';
import '../../utils/skeleton_loading/skeleton_favorite_item.dart';
import 'widgets/favorite_item.dart';

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

  final bool isLoading = false; // Simulate loading state

  FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.favorites(context),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined,
                color: theme.iconTheme.color),
            onPressed: () {},
          ),
        ],
        elevation: 0,
        backgroundColor: theme.cardColor,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double itemHeight = constraints.maxHeight * 0.1;
          double itemWidth = constraints.maxWidth;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: isLoading
                      ? 5
                      : favoriteItems.length, // Show skeletons if loading
                  itemBuilder: (context, index) {
                    if (isLoading) {
                      return SkeletonFavoriteItem(itemHeight: itemHeight);
                    }
                    return FavoriteItem(
                      item: favoriteItems[index],
                      itemHeight: itemHeight,
                    );
                  },
                ),
              ),
              if (!isLoading)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(itemWidth, 50),
                      backgroundColor: AppColor.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      // Add all to cart logic here
                    },
                    child: Text(
                      AppString.addAllToMyCart(context),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
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

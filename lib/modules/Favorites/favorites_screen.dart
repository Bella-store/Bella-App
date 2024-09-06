import 'package:bella_app/models/favorite_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../modules/Favorites/cubit/favorites_cubit.dart';
import '../../shared/app_string.dart';
import 'widgets/favorite_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

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
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritesLoadedState) {
            final favoritesCubit = context.read<FavoritesCubit>();

            // Get favorite products from all products based on their IDs
            final favoriteProducts =
                favoritesCubit.getFavoriteProducts(state.favoriteProductIds);

            if (favoriteProducts.isEmpty) {
              return const Center(child: Text("No favorites yet!"));
            }

            return ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];

                // Convert Product to FavoriteItemModel
                final favoriteItem = FavoriteItemModel(
                  id: product.id,
                  imageUrl: product.imageUrl,
                  title: product.title,
                  price: product.price,
                );

                return FavoriteItem(
                  item: favoriteItem,
                  itemHeight: 100,
                );
              },
            );
          } else if (state is FavoritesErrorState) {
            return Center(child: Text(state.message));
          }

          return const Center(child: Text('Something went wrong!'));
        },
      ),
    );
  }
}

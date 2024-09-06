import 'package:bella_app/models/product_model.dart';
import 'package:bella_app/modules/Home/widgets/product_details_screen.dart';
import 'package:bella_app/shared/app_color.dart';
import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import '../../../utils/skeleton_loading/skeleton_product_item.dart';
import '../../Home/widgets/product_details_screen.dart';
import '../../../shared/app_color.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final bool isLoading;

  const ProductItem({super.key, required this.product, this.isLoading = false});

  @override
  ProductItemState createState() => ProductItemState();
}

class ProductItemState extends State<ProductItem> {
  bool _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const SkeletonProductItem(); // Use the skeleton widget when loading
    }

    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: theme.cardColor,
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Display the product image here
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(product
                          .imageUrl), // Load image from network or Firebase URL
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Only this part is wrapped in BlocBuilder to rerender the heart icon alone
                Positioned(
                  top: 8,
                  right: 8,
                  child: BlocBuilder<FavoritesCubit, FavoritesState>(
                    buildWhen: (previous, current) {
                      // Only rebuild when the favorites list changes
                      return current is FavoritesLoadedState;
                    },
                    builder: (context, state) {
                      final isFavorite = state is FavoritesLoadedState &&
                          state.favoriteProductIds.contains(product.id);

                      return IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : AppColor.blackColor,
                        ),
                        onPressed: () {
                          final favoritesCubit = context.read<FavoritesCubit>();
                          if (isFavorite) {
                            favoritesCubit.removeFavorite(product.id);
                          } else {
                            favoritesCubit.addFavorite(product.id);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                product.title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColor.mainColor,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

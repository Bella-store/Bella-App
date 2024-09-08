import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/product_model.dart';
import '../../../shared/app_color.dart';
import '../../../shared/app_string.dart';
import '../../../utils/custom_snackbar.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../Favorites/cubit/favorites_cubit.dart';
import '../../Cart/cubit/cart_cubit.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  ProductDetailsScreenState createState() => ProductDetailsScreenState();
}

class ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _isExpanded = false;
  bool _showSeeMore = false;

  final GlobalKey _descriptionKey = GlobalKey();
  final TextStyle _descriptionTextStyle =
      const TextStyle(fontSize: 16, fontFamily: 'Montserrat');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox =
          _descriptionKey.currentContext?.findRenderObject() as RenderBox;
      final lines =
          (renderBox.size.height / _descriptionTextStyle.fontSize!).round();
      setState(() {
        _showSeeMore = lines > 3;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isWideScreen = MediaQuery.of(context).size.width > 600;
    final double responsiveHeight = screenHeight * 0.01;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: theme.iconTheme.color),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image with Favorite Icon
            Stack(
              children: [
                Center(
                  child: Image.network(
                    widget.product.imageUrl,
                    height: isWideScreen ? 400 : 300,
                    fit: BoxFit.cover,
                  ),
                ),
                // Heart icon with BlocBuilder to rerender only the icon
                Positioned(
                  top: 16,
                  right: 16,
                  child: BlocBuilder<FavoritesCubit, FavoritesState>(
                    buildWhen: (previous, current) {
                      // Only rebuild when the favorites list changes
                      return current is FavoritesLoadedState;
                    },
                    builder: (context, state) {
                      final isFavorite = state is FavoritesLoadedState &&
                          state.favoriteProductIds.contains(widget.product.id);

                      return IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color:
                              isFavorite ? Colors.red : theme.iconTheme.color,
                          size: 30,
                        ),
                        onPressed: () {
                          final favoritesCubit = context.read<FavoritesCubit>();
                          if (isFavorite) {
                            favoritesCubit.removeFavorite(widget.product.id);
                          } else {
                            favoritesCubit.addFavorite(widget.product.id);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),

            // Container with Product Details
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withOpacity(0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: isWideScreen ? 24 : 22,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Vado Odelle Dress',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 20),
                      SizedBox(width: 4),
                      Text(
                        '4.5', // Replace with actual rating
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '(320 Reviews)', // Replace with actual number of reviews
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppString.availableInStock(context),
                    style: const TextStyle(
                        color: Colors.green, fontFamily: 'Montserrat'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppString.description(context),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    key: _descriptionKey,
                    maxLines: _isExpanded ? null : 3,
                    overflow: _isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: _descriptionTextStyle,
                  ),
                  if (_showSeeMore)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Text(
                        _isExpanded ? 'See less' : 'See more',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.blue,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  SizedBox(height: responsiveHeight), // Use responsive height
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.product.price.toStringAsFixed(2)}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: AppColor.mainColor,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60.0, vertical: 15.0),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          final cartCubit = context.read<CartCubit>();
                          cartCubit.addToCart(widget.product.id);

                          // Show a snackbar message using CustomSnackbar
                          CustomSnackbar.show(
                            context,
                            title: 'Success',
                            message: 'Product added to the cart!',
                            contentType: ContentType.success,
                          );
                        },
                        child: Text(
                          AppString.addTocart(context),
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:bella_app/shared/app_color.dart';
import 'package:bella_app/shared/app_string.dart';
import '../../../models/product_model.dart';
import '../../Cart/cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  ProductDetailsScreenState createState() => ProductDetailsScreenState();
}

class ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _isExpanded = false;
  bool _showSeeMore = false;
  bool _isFavorite = false;

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

  final GlobalKey _descriptionKey = GlobalKey();
  final TextStyle _descriptionTextStyle = const TextStyle(fontSize: 16, fontFamily: 'Montserrat');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isWideScreen = MediaQuery.of(context).size.width > 600;
    final double responsiveHeight = screenHeight * 0.1; // Adjust the multiplier as needed

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image with Favorite Icon
            Stack(
              children: [
                Center(
                  child: Image.asset(
                    widget.product.imageUrl,
                    height: isWideScreen ? 400 : 300,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: IconButton(
                    icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? Colors.red : theme.iconTheme.color,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
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
                    style: const TextStyle(color: Colors.green, fontFamily: 'Montserrat'),
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
                    overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
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
                          padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 15.0),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CartScreen())); // Add to cart logic
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

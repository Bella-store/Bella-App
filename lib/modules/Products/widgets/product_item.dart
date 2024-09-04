import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import '../../Home/widgets/product_details_screen.dart';
import '../../../shared/app_color.dart';

class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

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
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: widget.product),
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
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    image: DecorationImage(
                      image: NetworkImage(widget.product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? Colors.red : AppColor.blackColor,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                widget.product.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
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
                '\$${widget.product.price.toStringAsFixed(2)}',
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

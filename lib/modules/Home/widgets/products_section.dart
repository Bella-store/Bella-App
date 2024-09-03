import 'package:bella_app/modules/Products/products_screen.dart';
import 'package:bella_app/modules/Products/widgets/product_item.dart';
import 'package:flutter/material.dart';
import '../../../models/product_model.dart';
import '../../../shared/app_string.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = 2;
        if (constraints.maxWidth > 800) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth > 600) {
          crossAxisCount = 3;
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppString.products(context),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductsScreen(),
                        ),
                      );
                    },
                    child: Text(
                      AppString.seeAll(context),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.75,
                ),
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return ProductItem(
                    product: productList[index],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

final List<Product> productList = [
  Product(
    id: '1',
    category: 'chair',
    imageUrl: AppString.chair,
    title: 'Stylish Wooden Chair',
    price: 130.0,
    description: 'This is a stylish wooden chair perfect for modern homes.', quantity: 3,
  ),
  Product(
    id: '2',
    category: 'table',
    imageUrl: AppString.table,
    title: 'Modern Chair',
    price: 150.0,
    description:
        'A modern chair with a sleek design, comfortable for daily use.', quantity: 2,
  ),
  Product(
    id: '3',
    category: 'table',
    imageUrl: AppString.table,
    title: 'Modern Chair',
    price: 150.0,
    description:
        'A modern chair with a sleek design, comfortable for daily use.', quantity: 1,
  ),
  Product(
    id: '4',
    category: 'chair',
    imageUrl: AppString.chair,
    title: 'Stylish Wooden Chair',
    price: 130.0,
    description: 'This is a stylish wooden chair perfect for modern homes.', quantity: 2,
  ),
];

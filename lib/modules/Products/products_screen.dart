import 'package:bella_app/models/product_model.dart';
import 'package:bella_app/shared/app_string.dart';
import 'package:bella_app/modules/Products/widgets/product_item.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.favorites(context),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Removes the screen from the stack
          },
        ),
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
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
        ),
      ),
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
    description: 'This is a stylish wooden chair perfect for modern homes.',
  ),
  Product(
    id: '2',
    category: 'table',
    imageUrl: AppString.table,
    title: 'Modern Chair',
    price: 150.0,
    description:
        'A modern chair with a sleek design, comfortable for daily use.',
  ),
  Product(
    id: '3',
    category: 'table',
    imageUrl: AppString.table,
    title: 'Modern Chair',
    price: 150.0,
    description:
        'A modern chair with a sleek design, comfortable for daily use.',
  ),
  Product(
    id: '4',
    category: 'chair',
    imageUrl: AppString.chair,
    title: 'Stylish Wooden Chair',
    price: 130.0,
    description: 'This is a stylish wooden chair perfect for modern homes.',
  ),
  Product(
    id: '5',
    category: 'chair',
    imageUrl: AppString.chair,
    title: 'Stylish Wooden Chair',
    price: 130.0,
    description: 'This is a stylish wooden chair perfect for modern homes.',
  ),
  Product(
    id: '6',
    category: 'chair',
    imageUrl: AppString.chair,
    title: 'Stylish Wooden Chair',
    price: 130.0,
    description: 'This is a stylish wooden chair perfect for modern homes.',
  ),
  Product(
    id: '7',
    category: 'chair',
    imageUrl: AppString.chair,
    title: 'Stylish Wooden Chair',
    price: 130.0,
    description: 'This is a stylish wooden chair perfect for modern homes.',
  ),
  Product(
    id: '8',
    category: 'chair',
    imageUrl: AppString.chair,
    title: 'Stylish Wooden Chair',
    price: 130.0,
    description: 'This is a stylish wooden chair perfect for modern homes.',
  ),
  Product(
    id: '9',
    category: 'chair',
    imageUrl: AppString.chair,
    title: 'Stylish Wooden Chair',
    price: 130.0,
    description: 'This is a stylish wooden chair perfect for modern homes.',
  ),
  Product(
    id: '10',
    category: 'chair',
    imageUrl: AppString.chair,
    title: 'Stylish Wooden Chair',
    price: 130.0,
    description: 'This is a stylish wooden chair perfect for modern homes.',
  ),
  Product(
    id: '11',
    category: 'chair',
    imageUrl: AppString.chair,
    title: 'Stylish Wooden Chair',
    price: 130.0,
    description: 'This is a stylish wooden chair perfect for modern homes.',
  ),
];

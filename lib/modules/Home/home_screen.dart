import 'package:flutter/material.dart';
import '../../Admin/modules/Products/add_products_screen.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/products_section.dart';
import 'widgets/search_bar.dart';
import 'widgets/categories_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).cardColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProductScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(screenSize: MediaQuery.of(context).size),
                  const SizedBox(height: 20),
                  const SearchWidget(),
                  const SizedBox(height: 20),
                  const CategoriesSection(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: ProductsSection(),
          ),
        ],
      ),
    );
  }
}

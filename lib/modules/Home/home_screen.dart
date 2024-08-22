import 'package:bella_app/modules/Home/widgets/custom_app_bar.dart';
import 'package:bella_app/modules/Home/widgets/products_section.dart';
import 'package:bella_app/modules/Home/widgets/search_bar.dart';
import 'package:flutter/material.dart';

import 'widgets/categories_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(screenSize: screenSize),
              const SizedBox(height: 20),
              const SearchWidget(),
              const SizedBox(height: 20),
              const CategoriesSection(),
              const SizedBox(height: 20),
              const ProductsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

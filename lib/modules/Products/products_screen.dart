import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/app_string.dart';
import 'cubit/all_products_cubit.dart';
import 'widgets/product_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.allProducts(context),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<AllProductsCubit, AllProductsState>(
        builder: (context, state) {
          if (state is ProductsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductsLoadedState) {
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                childAspectRatio: 0.75,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return ProductItem(
                  product: state.products[index],
                );
              },
            );
          } else if (state is ProductsEmptyState) {
            return Center(
                child: Text(AppString.noProductsFoundForThisCategory(context)));
          } else if (state is ProductsErrorState) {
            return Center(child: Text(state.message));
          } else {
            return Center(
                child: Text(AppString.pleaseSelectACategory(context)));
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/skeleton_loading/skeleton_product_item.dart';
import '../../../shared/app_string.dart';
import '../../Products/cubit/all_products_cubit.dart';
import '../../Products/products_screen.dart';
import '../../Products/widgets/product_item.dart';


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
              BlocBuilder<AllProductsCubit, AllProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoadingState) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: 8, // Show a few skeleton items while loading
                      itemBuilder: (context, index) {
                        return const SkeletonProductItem(); // Use the skeleton widget
                      },
                    );
                  }
                  if (state is ProductsLoadedState) {
                    final products = state.products;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductItem(
                          product: products[index],
                        );
                      },
                    );
                  } else if (state is ProductsEmptyState) {
                    //ToDo: translate here
                    return const Center(
                   child: Text("No products found")
                      // child: Text(AppString.noProductsFound(context)),
                    );
                  } else if (state is ProductsErrorState) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                     //ToDo: translate here
                    return const Center(
                      child: Text("Please select a category")
                      // child: Text(AppString.selectCategory(context)),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

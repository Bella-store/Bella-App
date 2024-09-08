import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../shared/app_string.dart';
import '../../../utils/skeleton_loading/skeleton_product_item.dart';
import '../../Products/cubit/all_products_cubit.dart';
import '../../Products/products_screen.dart';
import '../../Products/widgets/product_item.dart';


class ProductsSection extends StatelessWidget {
  final String searchTerm;

  const ProductsSection({super.key, required this.searchTerm});

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
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return const SkeletonProductItem();
                      },
                    );
                  }
                  if (state is ProductsLoadedState) {
                    final products = state.products.where((product) {
                      return product.title.toLowerCase().contains(searchTerm.toLowerCase());
                    }).toList();

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
                    return const Center(
                      child: Text('noProductsFound')// //ToDo: translate here
                      // child: Text(AppString.noProductsFound(context))
                      );
                  } else if (state is ProductsErrorState) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text(
                      'noProductsFound')
                      // AppString.selectCategory(context)) //ToDo: translate here
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

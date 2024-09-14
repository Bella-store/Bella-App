// cart_screen.dart
import 'package:bella_app/modules/Products/cubit/all_products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../utils/skeleton_loading/skeleton_cart_item.dart';
import 'cubit/cart_cubit.dart';
import 'widgets/cart_item.dart';
import '../../shared/app_string.dart';
import '../../shared/app_color.dart';
import 'widgets/order_summary.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key, required this.controller});

  final TextEditingController _promoCodeController = TextEditingController();
  final PersistentTabController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.myCart(context),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoadingState) {
            return ListView.builder(
              itemCount: 5, // Number of skeleton items to show
              itemBuilder: (context, index) {
                return const SkeletonCartItem(); // Show skeleton items while loading
              },
            );
          } else if (state is CartLoadedState && state.cartItems.isEmpty) {
            return Center(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AppString.notFound),
                  Text(
                    AppString.yourCartIsEmpty(context),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: AppColor.greyColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ));
          } else if (state is CartLoadedState) {
            return _buildCartContent(context, state);
          } else if (state is CartErrorState) {
            return Center(
                child: Column(
              children: [
                Image.asset(AppString.notFound),
                Text(
                  state.message,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColor.greyColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ));
          }
          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, CartLoadedState state) {
    final cartCubit = context.read<CartCubit>();
    return SingleChildScrollView(
      child: Column(
        children: [
          // Cart Items List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            itemCount: state.cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = state.cartItems[index];

              // Fetch the real product to get the available quantity
              final product =
                  cartCubit.productsCubit.state is ProductsLoadedState
                      ? (cartCubit.productsCubit.state as ProductsLoadedState)
                          .products
                          .firstWhere((product) => product.id == cartItem.id)
                      : null;

              final availableQuantity = product?.quantity ?? 0;

              return CartItem(
                item: cartItem,
                onRemove: () => cartCubit.removeFromCart(cartItem.id),
                onQuantityChanged: (isIncrement) =>
                    cartCubit.updateQuantity(cartItem.id, isIncrement),
                maxAvailableQuantity:
                    availableQuantity, // Pass available quantity to disable increment when max reached
              );
            },
          ),
          // Promo Code Input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _promoCodeController,
                    decoration: InputDecoration(
                      hintText: AppString.promoCode(context),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                IconButton(
                  onPressed: () {
                    cartCubit.applyPromoCode(_promoCodeController.text);
                  },
                  icon: const Icon(Icons.arrow_forward),
                  color: Colors.white,
                  iconSize: 30,
                  padding: const EdgeInsets.all(10.0),
                  constraints: const BoxConstraints(),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColor.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Total Amount and Checkout Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppString.total(context),
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${state.finalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Show modal bottom sheet with order summary
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      builder: (context) {
                        return OrderSummary(
                          context: context,
                          state: state,
                          controller: controller,
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: AppColor.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    AppString.checkOut(context),
                    style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

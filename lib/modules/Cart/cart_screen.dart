import 'package:bella_app/modules/Cart/cubit/cart_cubit.dart';
import 'package:bella_app/modules/Cart/widgets/cart_item.dart';
import 'package:bella_app/shared/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final TextEditingController _promoCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppString.myCart(context)),
          centerTitle: true,
          // leading: const BackButton(color: theme.iconTheme.color),
          elevation: 0,
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              return _buildCartContent(context, state);
            } else if (state is CartError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Unknown state'));
          },
        ),
      ),
    );
  }

  Widget _buildCartContent(BuildContext context, CartLoaded state) {
    final cartCubit = context.read<CartCubit>();
    return LayoutBuilder(
      builder: (context, constraints) {
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
                  return CartItem(
                    item: state.cartItems[index],
                    onRemove: () => cartCubit.removeItem(index),
                    onQuantityChanged: (isIncrement) =>
                        cartCubit.updateQuantity(index, isIncrement),
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
                        backgroundColor: Colors.black,
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
                        // Checkout logic
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.black,
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
      },
    );
  }
}

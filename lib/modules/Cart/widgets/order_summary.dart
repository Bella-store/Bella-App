
import 'package:flutter/material.dart';

import '../../../shared/app_color.dart';
import '../../../shared/app_string.dart';
import '../cubit/cart_cubit.dart';
import 'checkout_screen.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
    required this.context,
    required this.state,
  });

  final BuildContext context;
  final CartLoaded state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppString.orderSummary(context),
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),
          ListView.builder(
            shrinkWrap: true,
            itemCount: state.cartItems.length,
            itemBuilder: (context, index) {
              final item = state.cartItems[index];
              return ListTile(
                title: Text(item.title),
                subtitle: Text('${item.quantity} x \$${item.price.toStringAsFixed(2)}'),
                trailing: Text('\$${(item.quantity * item.price).toStringAsFixed(2)}'),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: Text(
              AppString.total(context),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              '\$${state.finalAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
                 Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CheckoutScreen()),
    );
              // Proceed to payment or next step
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: AppColor.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              AppString.proceedToPayment(context),
              style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontFamily: 'Montserrat'),
            ),
          ),
        ],
      ),
    );
  }
}

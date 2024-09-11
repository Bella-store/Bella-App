import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bella_app/modules/Cart/cubit/cart_cubit.dart';
import 'package:bella_app/modules/Products/cubit/all_products_cubit.dart';
import 'package:bella_app/modules/stripe_payment/payment_manager.dart';
import 'package:bella_app/shared/app_string.dart';
import 'package:bella_app/utils/custom_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../shared/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen(
      {super.key, required this.finalAmount, required this.controller});
  final double finalAmount;
  final PersistentTabController controller;

  @override
  CheckoutScreenState createState() => CheckoutScreenState();
}

class CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedOption = 'visa'; // Default selection
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          AppString.delivery(context),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDeliveryMethod(context, height),
              SizedBox(height: height * 0.02),
              _buildAddressDetails(context, height),
              SizedBox(height: height * 0.04),
              _buildProceedButton(context, width),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryMethod(BuildContext context, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.paymentMethod(context),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
        ),
        SizedBox(height: height * 0.01),
        RadioListTile<String>(
          value: 'visa',
          groupValue: _selectedOption,
          onChanged: (value) {
            setState(() {
              _selectedOption = value!;
            });
          },
          title: Text(
            AppString.visa(context),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
          ),
          subtitle: Text(
            AppString.payVisa(context),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          secondary: Icon(
            Icons.credit_card,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        RadioListTile<String>(
          value: 'pickup',
          groupValue: _selectedOption,
          onChanged: (value) {
            setState(() {
              _selectedOption = value!;
            });
          },
          title: Text(
            AppString.pickUp(context),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          subtitle: Text(
            AppString.pickUpSubtitle(context),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          secondary: Icon(
            Icons.location_on,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ],
    );
  }

  Widget _buildAddressDetails(BuildContext context, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.userInfo(context),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        ListTile(
          leading:
              Icon(Icons.location_on, color: Theme.of(context).iconTheme.color),
          title: Text(
            '591 Hill',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
          ),
          subtitle: Text(
            'Florida, Miami',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
          ),
          trailing: Icon(Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color),
          onTap: () {
            _showChangeDialog(context, AppString.changeAddress(context),
                AppString.enterAddress(context));
          },
        ),
        ListTile(
          leading: Icon(Icons.phone, color: Theme.of(context).iconTheme.color),
          title: Text(
            '(620) 555-0273',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
          ),
          trailing: Icon(Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color),
          onTap: () {
            _showChangeDialog(context, AppString.changePhoneNumber(context),
                AppString.enterPhoneNumber(context));
          },
        ),
        ListTile(
          leading: Icon(Icons.email, color: Theme.of(context).iconTheme.color),
          title: Text(
            'joan.aubrey@gmail.com',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
          ),
          trailing: Icon(Icons.arrow_forward_ios,
              color: Theme.of(context).iconTheme.color),
          onTap: () {
            _showChangeDialog(context, AppString.changeEmail(context),
                AppString.enterEmail(context));
          },
        ),
      ],
    );
  }

  // The function to handle order processing
  Future<void> processOrder(String paymentMethod) async {
    try {
      // Get current user ID
      final User? user = _auth.currentUser;
      if (user == null) {
        // User not logged in
        throw Exception("User not logged in");
      }

      // Fetch cart details from Firebase
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userDoc.exists || !userDoc.data()!.containsKey('cartProducts')) {
        throw Exception('Cart is empty or user data is missing.');
      }

      final cartProducts =
          List<Map<String, dynamic>>.from(userDoc.data()!['cartProducts']);

      // Prepare the cart details to be added to the orders collection
      final List<Map<String, dynamic>> orderDetails =
          cartProducts.map((product) {
        return {
          'productId': product['id'],
          'quantity': product['quantity'],
        };
      }).toList();

      // Add order details to Firestore orders collection
      DocumentReference orderRef =
          await FirebaseFirestore.instance.collection('orders').add({
        'userId': user.uid,
        'orderDetails': orderDetails,
        'orderDate': DateTime.now(),
        'paymentMethod': paymentMethod,
        'orderStatusId': 'TUgeq6U27JsTojE1XukC',
      });

      // Update order with the document ID as orderId
      await orderRef.update({'orderId': orderRef.id});

      // Update product quantities in the Firestore products collection
      for (var product in cartProducts) {
        final productRef = FirebaseFirestore.instance
            .collection('products')
            .doc(product['id']);

        await FirebaseFirestore.instance.runTransaction((transaction) async {
          final snapshot = await transaction.get(productRef);
          if (snapshot.exists) {
            final currentQuantity = snapshot.data()?['quantity'] ?? 0;
            final newQuantity = currentQuantity - product['quantity'];
            if (newQuantity >= 0) {
              transaction.update(productRef, {'quantity': newQuantity});
            } else {
              throw Exception(
                  'Insufficient stock for product ${product['id']}');
            }
          }
        });
      }

      // Clear the cart in the user's document
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'cartProducts': []});

      // Reload products using AllProductsCubit and wait for it to complete
      final allProductsCubit = context.read<AllProductsCubit>();
      await allProductsCubit.loadAllProducts();

      // Clear cart using CartCubit
      context.read<CartCubit>().loadCart();

      // Close all screens up to the Cart Screen and go to Home Screen
      Navigator.popUntil(context, (route) => route.isFirst);
      widget.controller.jumpToTab(0);

      // Show success message using CustomSnackbar
      CustomSnackbar.show(
        context,
        title: 'Success!',
        message: 'Order Placed Successfully',
        contentType: ContentType.success,
      );
    } catch (e) {
      // Handle any errors that occur during order processing
      if (kDebugMode) {
        print("Order processing failed: $e");
      }
      // Optionally show an error message to the user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildProceedButton(BuildContext context, double width) {
    return ElevatedButton(
      onPressed: () async {
        try {
          String paymentMethod = _selectedOption;

          // Check payment method and handle accordingly
          if (paymentMethod == 'visa') {
            // Trigger the Visa payment process
            await PaymentManager.makePayment(widget.finalAmount.toInt(), "USD");
            // If payment is successful, process the order
            await processOrder(paymentMethod);
          } else if (paymentMethod == 'pickup') {
            // If paying on pickup, process the order directly
            await processOrder(paymentMethod);

            // Navigate to My Order screen after order processing
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const MyOrderScreen()),
            // );
          }
        } catch (e) {
          // Handle any errors that occur during payment or order processing
          // if (kDebugMode) {
          //   print("Payment failed: $e");
          // }
          // Optionally show an error message to the user
          // showDialog(
          //   context: context,
          //   builder: (context) => AlertDialog(
          //     title: Text('Error'),
          //     content: Text(e.toString()),
          //     actions: [
          //       TextButton(
          //         onPressed: () => Navigator.pop(context),
          //         child: Text('OK'),
          //       ),
          //     ],
          //   ),
          // );
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, 50),
        backgroundColor: AppColor.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Text(
        AppString.continuePayment(context),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }

  void _showChangeDialog(BuildContext context, String title, String hint) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppString.cancel(context),
                  style: Theme.of(context).textTheme.labelLarge),
            ),
            TextButton(
              onPressed: () {
                // Implement your logic to save the updated information
                Navigator.of(context).pop();
              },
              child: Text(AppString.save(context),
                  style: Theme.of(context).textTheme.labelLarge),
            ),
          ],
        );
      },
    );
  }
}

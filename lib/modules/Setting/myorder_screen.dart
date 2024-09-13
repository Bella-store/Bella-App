import 'package:bella_app/modules/Products/cubit/all_products_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../shared/app_string.dart';
import '../../models/order_item_model.dart'; // Import your OrderItemModel

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  MyOrderScreenState createState() => MyOrderScreenState();
}

class MyOrderScreenState extends State<MyOrderScreen> {
  // Map to hold order statuses with their IDs as keys and names as values
  Map<String, String> orderStatusMap = {};

  @override
  void initState() {
    super.initState();
    _fetchOrderStatuses();
  }

  // Fetch order statuses from Firestore and populate the map
  Future<void> _fetchOrderStatuses() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('orderStatus').get();
      setState(() {
        orderStatusMap = {
          for (var doc in snapshot.docs) doc.id: doc['statusName'],
        };
      });
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch order statuses: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Ensure the order statuses are loaded before displaying the screen
    if (orderStatusMap.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppString.myOrders(context),
            style: const TextStyle(fontFamily: 'Montserrat'),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: theme.primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: theme.primaryColor,
            labelStyle: const TextStyle(fontFamily: 'Montserrat'),
            tabs: [
              Tab(text: AppString.delivered(context)),
              Tab(text: AppString.processing(context)),
              Tab(text: AppString.canceled(context)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OrderListView(statusId: _getStatusId('Completed')),
            OrderListView(statusId: _getStatusId('Processing')),
            OrderListView(statusId: _getStatusId('Canceled')),
          ],
        ),
      ),
    );
  }

  // Helper method to get status ID by status name
  String _getStatusId(String statusName) {
    return orderStatusMap.entries
        .firstWhere((entry) => entry.value == statusName,
            orElse: () => const MapEntry('', ''))
        .key;
  }
}

class OrderListView extends StatelessWidget {
  final String statusId;

  const OrderListView({super.key, required this.statusId});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Center(child: Text('Please log in to see your orders.'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: currentUser.uid)
          .where('orderStatusId', isEqualTo: statusId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No orders found.'));
        }

        // Convert each document into OrderItemModel
        final orders = snapshot.data!.docs.map((doc) {
          return OrderItemModel.fromDocument(
              doc.data() as Map<String, dynamic>, doc.id);
        }).toList();

        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];

            return FutureBuilder<double>(
              future: _calculateTotalAmount(order.orderDetails, context),
              builder: (context, totalSnapshot) {
                if (totalSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final totalAmount = totalSnapshot.data ?? 0.0;

                return OrderCard(
                  orderId: order.orderId.substring(0, 7),
                  orderDate: order.orderDate,
                  quantity: order.orderDetails.length,
                  totalAmount: totalAmount,
                  statusName: _getStatusName(context, order.orderStatusId),
                );
              },
            );
          },
        );
      },
    );
  }

  // Fetch product details and calculate the total amount
  Future<double> _calculateTotalAmount(
      List<OrderDetail> orderDetails, BuildContext context) async {
    double total = 0.0;
    final cubit = AllProductsCubit();

    if (cubit.state is! ProductsLoadedState) {
      await cubit.loadAllProducts();
    }

    for (var item in orderDetails) {
      final productId = item.productId;
      final quantity = item.quantity;
      final product = cubit.getProductById(productId);

      if (product != null) {
        total += (product.price * quantity);
      }
    }

    return total;
  }

  // Get status name from the map using the status ID
  String _getStatusName(BuildContext context, String statusId) {
    final myOrderScreenState =
        context.findAncestorStateOfType<MyOrderScreenState>();
    return myOrderScreenState?.orderStatusMap[statusId] ?? 'Unknown Status';
  }
}

class OrderCard extends StatelessWidget {
  final String orderId;
  final DateTime orderDate;
  final int quantity;
  final double totalAmount;
  final String statusName;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.orderDate,
    required this.quantity,
    required this.totalAmount,
    required this.statusName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Determine the color and text based on the status name
    Color statusColor;
    switch (statusName) {
      case 'Completed':
        statusColor = Colors.green;
        break;
      case 'Processing':
        statusColor = Colors.orange;
        break;
      case 'Canceled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: theme.cardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order No. $orderId',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  Text(
                    '${orderDate.day}/${orderDate.month}/${orderDate.year}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: AppString.quantity(context),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontFamily: 'Montserrat',
                      ),
                      children: [
                        TextSpan(
                          text: '$quantity',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.bodyLarge?.color,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: AppString.totalAmount(context),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontFamily: 'Montserrat',
                      ),
                      children: [
                        TextSpan(
                          text: '\$$totalAmount',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.bodyLarge?.color,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: theme.primaryColor,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     // Handle detail button press
                  //   },
                  //   child: Text(
                  //     AppString.detail(context),
                  //     style: const TextStyle(
                  //         color: Colors.white, fontFamily: 'Montserrat'),
                  //   ),
                  // ),
                  Text(
                    statusName,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

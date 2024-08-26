import 'package:flutter/material.dart';
import 'package:bella_app/shared/app_color.dart';

import '../../shared/app_string.dart'; // Assuming you have a shared color file

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppString.myOrders),
          centerTitle: true,
          bottom:  TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: AppString.delivered),
              Tab(text: AppString.processing),
              Tab(text: AppString.canceled),
            ],
          ),
        ),
        body:  TabBarView(
          children: [
            OrderListView(status: AppString.delivered),
            OrderListView(status: AppString.processing),
            OrderListView(status: AppString.canceled),
          ],
        ),
      ),
    );
  }
}

class OrderListView extends StatelessWidget {
  final String status;

  const OrderListView({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2, 
      itemBuilder: (context, index) {
        return OrderCard(status: status);
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final String status;

  const OrderCard({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // Determine the color and text for the status
    Color statusColor;
    String statusText;

    switch (status) {
      case "Processing":
        statusColor = Colors.orange;
        statusText = AppString.processing;
        break;
      case "Canceled":
        statusColor = Colors.red;
        statusText = AppString.canceled;
        break;
      case "Delivered":
      default:
        statusColor = Colors.green;
        statusText = AppString.delivered;
        break;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color:
                AppColor.whiteColor, 
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: constraints.maxWidth < 600
                  ? const EdgeInsets.all(16.0)
                  : const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order No238562312',
                        style: TextStyle(
                          fontSize: constraints.maxWidth < 600 ? 16 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '20/03/2020',
                        style: TextStyle(
                          fontSize: constraints.maxWidth < 600 ? 14 : 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(height: constraints.maxWidth < 600 ? 10 : 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: AppString.quantity,
                          style: TextStyle(
                            fontSize: constraints.maxWidth < 600 ? 14 : 18,
                            color: Colors.grey,
                          ),
                          children: const [
                            TextSpan(
                              text: '03',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: AppString.totalAmount,
                          style: TextStyle(
                            fontSize: constraints.maxWidth < 600 ? 14 : 18,
                            color: Colors.grey,
                          ),
                          children: const [
                            TextSpan(
                              text: '\$150',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: constraints.maxWidth < 600 ? 10 : 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          // Handle detail button press
                        },
                        child:  Text(
                          AppString.detail,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Text(
                        statusText,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: constraints.maxWidth < 600 ? 14 : 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

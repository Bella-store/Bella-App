import 'package:flutter/material.dart';
import '../../shared/app_string.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
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
            OrderListView(status: AppString.delivered(context)),
            OrderListView(status: AppString.processing(context)),
            OrderListView(status: AppString.canceled(context)),
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
    final theme = Theme.of(context);
    
    // Determine the color and text for the status
    Color statusColor;
    String statusText;

    switch (status) {
      case "Processing":
        statusColor = Colors.orange;
        statusText = AppString.processing(context);
        break;
      case "Canceled":
        statusColor = Colors.red;
        statusText = AppString.canceled(context);
        break;
      case "Delivered":
      default:
        statusColor = Colors.green;
        statusText = AppString.delivered(context);
        break;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: theme.cardColor,
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
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Text(
                        '20/03/2020',
                        style: TextStyle(
                          fontSize: constraints.maxWidth < 600 ? 14 : 18,
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
                  SizedBox(height: constraints.maxWidth < 600 ? 10 : 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: AppString.quantity(context),
                          style: TextStyle(
                            fontSize: constraints.maxWidth < 600 ? 14 : 18,
                            color: Colors.grey,
                            fontFamily: 'Montserrat',
                          ),
                          children: [
                            TextSpan(
                              text: '03',
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
                          style: TextStyle(
                            fontSize: constraints.maxWidth < 600 ? 14 : 18,
                            color: Colors.grey,
                            fontFamily: 'Montserrat',
                          ),
                          children: [
                            TextSpan(
                              text: '\$150',
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
                  SizedBox(height: constraints.maxWidth < 600 ? 10 : 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          // Handle detail button press
                        },
                        child: Text(
                          AppString.detail(context),
                          style: const TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                        ),
                      ),
                      Text(
                        statusText,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: constraints.maxWidth < 600 ? 14 : 18,
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
      },
    );
  }
}

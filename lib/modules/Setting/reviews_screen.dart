import 'package:flutter/material.dart';

import '../../shared/app_string.dart';

class MyReviewsScreen extends StatelessWidget {
  const MyReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppString.myReviews(context)),
           centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality if needed
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return const ReviewCard();
          },
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg?auto=compress&cs=tinysrgb&w=600',
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Coffee Table',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '\$50.00',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  '09/08/2024',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: List.generate(5, (index) {
                return const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 20,
                );
              }),
            ),
            const SizedBox(height: 16),
            const Text(
              'Nice Furniture with good delivery. The delivery time is very fast. '
              'Then products look like exactly the picture in the app. '
              'Besides, color is also the same and quality is very good despite very cheap price.',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

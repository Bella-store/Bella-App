import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItemModel {
  final String orderId;
  final String userId;
  final List<OrderDetail> orderDetails;
  final DateTime orderDate;
  final String paymentMethod;
  final String orderStatusId;

  OrderItemModel({
    required this.orderId,
    required this.userId,
    required this.orderDetails,
    required this.orderDate,
    required this.paymentMethod,
    required this.orderStatusId,
  });

  // Factory method to create OrderItemModel from Firestore document
  factory OrderItemModel.fromDocument(Map<String, dynamic> doc, String docId) {
    return OrderItemModel(
      orderId: docId,
      userId: doc['userId'] as String,
      orderDetails: (doc['orderDetails'] as List)
          .map((item) => OrderDetail.fromMap(item))
          .toList(),
      orderDate: (doc['orderDate'] as Timestamp).toDate(),
      paymentMethod: doc['paymentMethod'] as String,
      orderStatusId: doc['orderStatusId'] as String,
    );
  }

  // Convert OrderItemModel to map (useful for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'orderDetails': orderDetails.map((item) => item.toMap()).toList(),
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'orderStatusId': orderStatusId,
    };
  }
}

// OrderDetail model to represent each product in the order
class OrderDetail {
  final String productId;
  final int quantity;

  OrderDetail({
    required this.productId,
    required this.quantity,
  });

  // Factory method to create OrderDetail from map
  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      productId: map['productId'] as String,
      quantity: map['quantity'] as int,
    );
  }

  // Convert OrderDetail to map
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}

part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> cartItems;
  final double totalAmount;
  final double discount;
  CartLoaded(
      {required this.cartItems,
      required this.totalAmount,
      this.discount = 0.0});
  double get finalAmount => totalAmount - (totalAmount * discount);
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}

class RemoveItem extends CartState {}

class EditQuantity extends CartState {}

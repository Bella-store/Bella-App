part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {
  final List<CartItemModel> cartItems;
  final double discount;

  CartLoadedState({
    required this.cartItems,
    this.discount = 0.0,
  });

  // Calculate the total amount by summing up the total price of each cart item
  double get totalAmount =>
      cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  // Calculate the final amount after applying the discount
  double get finalAmount => totalAmount - (totalAmount * discount);
}

class CartErrorState extends CartState {
  final String message;

  CartErrorState(this.message);
}

class RemoveItem extends CartState {}

class EditQuantity extends CartState {}

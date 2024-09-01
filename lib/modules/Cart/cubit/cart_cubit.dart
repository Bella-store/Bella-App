import 'package:bella_app/models/cart_item_model.dart';
import 'package:bella_app/shared/app_string.dart';
import 'package:bloc/bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial()) {
    _loadCart();
  }
  void _loadCart() {
    final cartItems = [
      CartItemModel(
        imageUrl: AppString.chair,
        title: 'Minimal Stand',
        price: 25.00,
      ),
      CartItemModel(
        imageUrl: AppString.table,
        title: 'Coffee Table',
        price: 20.00,
      ),
      CartItemModel(
        imageUrl: AppString.chair,
        title: 'Minimal Desk',
        price: 50.00,
      ),
    ];
    emit(CartLoaded(
        cartItems: cartItems, totalAmount: _calculateTotalAmount(cartItems)));
  }

  double _calculateTotalAmount(List<CartItemModel> cartItems) {
    return cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  void removeItem(int index) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final updatedCart = List<CartItemModel>.from(currentState.cartItems);
      updatedCart.removeAt(index);
      emit(CartLoaded(
        cartItems: updatedCart,
        totalAmount: _calculateTotalAmount(updatedCart),
        discount: currentState.discount,
      ));
    }
  }

  void applyPromoCode(String promoCode) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final discount = promoCode == 'ysf' ? 0.10 : 0.0;
      emit(CartLoaded(
        cartItems: currentState.cartItems,
        totalAmount: currentState.totalAmount,
        discount: discount,
      ));
    }
  }

  void updateQuantity(int index, bool isIncrement) {
    if (state is CartLoaded) {
      final currentState = state as CartLoaded;
      final updatedCart = List<CartItemModel>.from(currentState.cartItems);
      if (isIncrement) {
        updatedCart[index].increaseQuantity();
      } else {
        updatedCart[index].decreaseQuantity();
      }
      emit(CartLoaded(
        cartItems: updatedCart,
        totalAmount: _calculateTotalAmount(updatedCart),
        discount: currentState.discount,
      ));
    }
  }
}

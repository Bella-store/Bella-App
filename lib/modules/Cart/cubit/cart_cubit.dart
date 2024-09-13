// cart_cubit.dart
import 'package:bella_app/models/cart_item_model.dart';
import 'package:bella_app/models/product_model.dart';
import 'package:bella_app/modules/Products/cubit/all_products_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  final AllProductsCubit productsCubit;

  CartCubit({required this.productsCubit}) : super(CartInitial()) {
    // Listen to changes in the products cubit state to reload cart if needed
    productsCubit.stream.listen((state) {
      if (state is ProductsLoadedState) {
        loadCart(); // Attempt to reload cart when products are loaded
      }
    });
  }

  // Load cart products based on IDs in the user model
  void loadCart() async {
    emit(CartLoadingState());
    try {
      // Check if products are loaded
      if (productsCubit.state is! ProductsLoadedState) {
        emit(CartErrorState("Products not loaded yet. Please try again."));
        return;
      }

      final userDoc =
          await _firestore.collection('users').doc(_currentUser?.uid).get();
      final List<dynamic> cartProducts = userDoc.data()?['cartProducts'] ?? [];
      if (productsCubit.state is ProductsLoadedState) {
        final allProducts =
            (productsCubit.state as ProductsLoadedState).products;

        // Map cart products from Firestore to CartItemModel
        final cartItems = cartProducts
            .map((cartItem) {
              final product = allProducts.firstWhere(
                (prod) => prod.id == cartItem['id'],
                orElse: () => Product(
                    id: '',
                    title: 'Unknown Product',
                    description: '',
                    price: 0.0,
                    category: "",
                    quantity: 0,
                    imageUrl: ''),
              );

              return product.id != ''
                  ? CartItemModel(
                      id: product.id,
                      imageUrl: product.imageUrl,
                      title: product.title,
                      price: product.price,
                      quantity: cartItem['quantity'] ?? 1,
                    )
                  : null;
            })
            .whereType<CartItemModel>()
            .toList();
        emit(CartLoadedState(cartItems: cartItems));
      } else {
        emit(CartErrorState("Failed to load products."));
      }
    } catch (e) {
      emit(CartErrorState("Failed to load cart."));
    }
  }

  // Add a product to the cart
  void addToCart(String productId) async {
    if (_currentUser == null) return;

    try {
      final userDoc = _firestore.collection('users').doc(_currentUser.uid);
      final cartData = (await userDoc.get()).data()?['cartProducts'] ?? [];

      final existingProduct = cartData.firstWhere(
        (item) => item['id'] == productId,
        orElse: () => null,
      );

      if (existingProduct == null) {
        cartData.add({'id': productId, 'quantity': 1});
      }

      await userDoc.update({'cartProducts': cartData});

      _updateLocalCart(cartData);
    } catch (e) {
      emit(CartErrorState("Failed to add to cart."));
    }
  }

  // Remove a product from the cart
  void removeFromCart(String productId) async {
    if (_currentUser == null) return;

    try {
      final userDoc = _firestore.collection('users').doc(_currentUser.uid);
      final cartData = (await userDoc.get()).data()?['cartProducts'] ?? [];

      cartData.removeWhere((item) => item['id'] == productId);

      await userDoc.update({'cartProducts': cartData});
      _updateLocalCart(cartData);
    } catch (e) {
      emit(CartErrorState("Failed to remove from cart."));
    }
  }

  // Update the quantity of a cart item
  void updateQuantity(String productId, bool isIncrement) async {
    if (_currentUser == null) return;

    try {
      final userDoc =
          await _firestore.collection('users').doc(_currentUser.uid).get();
      final List<dynamic> cartData = userDoc.data()?['cartProducts'] ?? [];

      final cartItem = cartData.firstWhere(
        (item) => item['id'] == productId,
        orElse: () => null,
      );

      if (cartItem != null) {
        final product = (productsCubit.state as ProductsLoadedState)
            .products
            .firstWhere((prod) => prod.id == productId);

        if (isIncrement && cartItem['quantity'] < product.quantity) {
          cartItem['quantity'] += 1;
        } else if (!isIncrement && cartItem['quantity'] > 1) {
          cartItem['quantity'] -= 1;
        }

        if (cartItem['quantity'] <= 0) {
          cartData.remove(cartItem);
        }
      }

      await _firestore.collection('users').doc(_currentUser.uid).update({
        'cartProducts': cartData,
      });

      _updateLocalCart(cartData);
    } catch (e) {
      emit(CartErrorState("Failed to update quantity."));
    }
  }

  // Update the local cart state with modified cart data
  void _updateLocalCart(List<dynamic> cartData) {
    if (productsCubit.state is ProductsLoadedState) {
      final allProducts = (productsCubit.state as ProductsLoadedState).products;

      final cartItems = cartData
          .map((cartItem) {
            final product = allProducts.firstWhere(
              (prod) => prod.id == cartItem['id'],
              orElse: () => Product(
                  id: '',
                  title: 'Unknown Product',
                  description: '',
                  price: 0.0,
                  category: "",
                  quantity: 0,
                  imageUrl: ''),
            );

            return product.id != ''
                ? CartItemModel(
                    id: product.id,
                    imageUrl: product.imageUrl,
                    title: product.title,
                    price: product.price,
                    quantity: cartItem['quantity'] ?? 1,
                  )
                : null;
          })
          .whereType<CartItemModel>()
          .toList();
      emit(CartLoadedState(cartItems: cartItems));
    } else {
      emit(CartErrorState("Failed to update cart items."));
    }
  }

  void applyPromoCode(String promoCode) {
    if (state is CartLoadedState) {
      final currentState = state as CartLoadedState;
      final discount = promoCode == 'ysf' ? 0.10 : 0.0;
      emit(CartLoadedState(
        cartItems: currentState.cartItems,
        discount: discount,
      ));
    }
  }
}

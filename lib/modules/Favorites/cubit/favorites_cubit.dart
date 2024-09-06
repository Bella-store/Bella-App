import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bella_app/models/product_model.dart';
import 'package:bella_app/modules/Products/cubit/all_products_cubit.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  final AllProductsCubit productsCubit;

  FavoritesCubit({required this.productsCubit}) : super(FavoritesInitial());

  // Load favorite product IDs
  void loadFavorites() async {
    emit(FavoritesLoadingState());
    try {
      final userDoc =
          await _firestore.collection('users').doc(_currentUser?.uid).get();
      final List<dynamic> favoriteProductIds =
          userDoc.data()?['favoriteProducts'] ?? [];
      emit(FavoritesLoadedState(
          favoriteProductIds.map((id) => id.toString()).toList()));
    } catch (e) {
      emit(FavoritesErrorState("Failed to load favorites."));
    }
  }

  // Add product ID to favorites
  void addFavorite(String productId) async {
    if (_currentUser == null) return;

    try {
      final userDoc = _firestore.collection('users').doc(_currentUser.uid);
      await userDoc.update({
        'favoriteProducts': FieldValue.arrayUnion([productId]),
      });

      loadFavorites(); // Reload favorites after adding
    } catch (e) {
      emit(FavoritesErrorState("Failed to add to favorites."));
    }
  }

  // Remove product ID from favorites
  void removeFavorite(String productId) async {
    if (_currentUser == null) return;

    try {
      final userDoc = _firestore.collection('users').doc(_currentUser.uid);
      await userDoc.update({
        'favoriteProducts': FieldValue.arrayRemove([productId]),
      });

      loadFavorites(); // Reload favorites after removing
    } catch (e) {
      emit(FavoritesErrorState("Failed to remove from favorites."));
    }
  }

  // Get favorite products from all products
  List<Product> getFavoriteProducts(List<String> favoriteProductIds) {
    if (productsCubit.state is ProductsLoadedState) {
      final allProducts = (productsCubit.state as ProductsLoadedState).products;

      // Safely retrieve products from the list based on their IDs
      return favoriteProductIds
          .map((id) => allProducts.firstWhere(
                (product) => product.id == id,
                orElse: () => Product(
                    id: '',
                    title: 'Unknown Product',
                    description: '',
                    price: 0.0,
                    category: "",
                    quantity: 0,
                    imageUrl: ''), // Create a placeholder product if not found
              ))
          .where((product) =>
              product.id.isNotEmpty) // Exclude placeholder products
          .toList();
    } else {
      return [];
    }
  }
}

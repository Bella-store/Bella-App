import 'package:bloc/bloc.dart';
import 'package:bella_app/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'all_products_state.dart';

class AllProductsCubit extends Cubit<AllProductsState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AllProductsCubit() : super(ProductsInitial());

  // Load all products
  void loadAllProducts() async {
    emit(ProductsLoadingState());
    try {
      final querySnapshot = await _firestore.collection('products').get();
      final products = querySnapshot.docs.map((doc) {
        return Product(
          id: doc.id,
          category: doc['category'],
          imageUrl: doc['imageUrl'],
          title: doc['title'],
          price: doc['price'],
          description: doc['description'],
          quantity: doc['quantity'],
        );
      }).toList();

      emit(ProductsLoadedState(products));
    } catch (e) {
      emit(ProductsErrorState("Failed to load products."));
    }
  }
  // Get product by ID
  // Product? getProductById(String productId) {
  //   if (state is ProductsLoadedState) {
  //     final products = (state as ProductsLoadedState).products;
  //     return products.firstWhere(
  //       (product) => product.id == productId,
  //       orElse: () => null,
  //     );
  //   }
  //   return null;
  // }
  /// Retrieves a product by its ID from the current loaded products.
  Product? getProductById(String productId) {
    if (state is ProductsLoadedState) {
      final products = (state as ProductsLoadedState).products;

      // Use `firstWhere` without `orElse`, then handle if product is null after.
      for (var product in products) {
        if (product.id == productId) {
          return product;
        }
      }
      return null; // Return null if no product matches the condition.
    }
    return null;
  }
  // Load products by category
  void loadProductsByCategory(String category) async {
    emit(ProductsLoadingState());
    try {
      final querySnapshot = await _firestore
          .collection('products')
          .where('category', isEqualTo: category)
          .get();
      final products = querySnapshot.docs.map((doc) {
        return Product(
          id: doc.id,
          category: doc['category'],
          imageUrl: doc['imageUrl'],
          title: doc['title'],
          price: doc['price'],
          description: doc['description'],
          quantity: doc['quantity'],
        );
      }).toList();

      if (products.isEmpty) {
        emit(ProductsEmptyState());
      } else {
        emit(ProductsLoadedState(products));
      }
    } catch (e) {
      emit(ProductsErrorState("Failed to load products."));
    }
  }

  // Reset to all products
  void resetProducts() {
    loadAllProducts();
  }
}

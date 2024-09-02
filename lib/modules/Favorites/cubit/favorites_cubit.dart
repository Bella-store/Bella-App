import 'package:bella_app/models/favorite_item_model.dart';
import 'package:bella_app/shared/app_string.dart';
import 'package:bloc/bloc.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  void loadFavorites() {
    emit(FavoritesLoadingState());
    try {
      final List<FavoriteItemModel> favoriteItems = [
        FavoriteItemModel(
            imageUrl: AppString.chair, title: 'Coffee Table', price: 50.00),
        FavoriteItemModel(
            imageUrl: AppString.table, title: 'Coffee Chair', price: 20.00),
        FavoriteItemModel(
            imageUrl: AppString.chair, title: 'Minimal Stand', price: 25.00),
        FavoriteItemModel(
            imageUrl: AppString.table, title: 'Minimal Desk', price: 50.00),
        FavoriteItemModel(
            imageUrl: AppString.chair, title: 'Minimal Lamp', price: 12.00),
      ];

      if (favoriteItems.isEmpty) {
        emit(FavoritesEmptyState());
      } else {
        emit(FavoritesLoadedState(favoriteItems));
      }
    } catch (e) {
      emit(FavoritesErrorState("Failed to load favorites."));
    }
  }

  void removeItem(int index) {
    if (state is FavoritesLoadedState) {
      final currentState = state as FavoritesLoadedState;
      final updatedFavorites =
          List<FavoriteItemModel>.from(currentState.favoriteItems);
      updatedFavorites.removeAt(index);
      if (updatedFavorites.isEmpty) {
        emit(FavoritesEmptyState());
      } else {
        emit(FavoritesLoadedState(updatedFavorites));
      }
    }
  }

  void addToCart(FavoriteItemModel item) {
    // Logic for adding the item to the cart
  }
}

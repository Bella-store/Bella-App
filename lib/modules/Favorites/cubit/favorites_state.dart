part of 'favorites_cubit.dart';

abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoadingState extends FavoritesState {}

class FavoritesLoadedState extends FavoritesState {
  final List<String> favoriteProductIds; // Correct name used here
  FavoritesLoadedState(this.favoriteProductIds);
}

class FavoritesEmptyState extends FavoritesState {}

class FavoritesErrorState extends FavoritesState {
  final String message;
  FavoritesErrorState(this.message);
}
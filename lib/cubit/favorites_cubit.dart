import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<List<String>> {
  FavoritesCubit() : super([]);

  void toggleFavorite(String productId) {
    if (state.contains(productId)) {
      emit(state.where((id) => id != productId).toList());
    } else {
      emit([...state, productId]);
    }
  }
}
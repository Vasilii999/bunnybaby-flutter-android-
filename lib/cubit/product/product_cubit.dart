import 'package:figma21/core/exports_cubit.dart';
import 'package:figma21/core/exports_firebase.dart';
import 'package:figma21/core/exports_models.dart';
import 'package:figma21/cubit/product/product_state.dart';

class ProductCubit extends Cubit<ProductState>{
  ProductCubit() : super(ProductInitial());
  
  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final snapshot = await FirebaseFirestore.instance.collection('products').get();
      
      final products = snapshot.docs.map((doc) {
        return ProductFirebase.fromDocument(doc);
      }).toList();

      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError('Ошибка при загрузку товаров: $e'));
    }
  }
}
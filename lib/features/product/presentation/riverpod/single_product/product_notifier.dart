import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cleanarch/features/product/presentation/riverpod/single_product/product_state.dart';

import '../../../domain/usecases/get_product_usecase.dart';


class ProductNotifier extends StateNotifier<ProductState> {
  final ProductUseCase getProduct;

  ProductNotifier(this.getProduct) : super(ProductInitial());

  Future<void> fetchProduct(int id) async {
    state = ProductLoading();
    try {
      final product = await getProduct(id: id);
      state = ProductLoaded(product);
    } catch (e) {
      state = ProductError(e.toString());
    }
  }
}

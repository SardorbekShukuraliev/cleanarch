import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cleanarch/features/product/domain/usecases/get_all_products_usecase.dart';
import 'package:cleanarch/features/product/domain/usecases/sort_products_usecase.dart';
import '../../../domain/usecases/search_products_usecase.dart';
import 'all_products_state.dart';

class AllProductsNotifier extends StateNotifier<AllProductsState> {
  final GetAllProductsUsecase getAllProduct;
  final SearchProductsUsecase searchProductsUsecase;
  final SortProductsUsecase sortProductsUsecase;

  AllProductsNotifier({
    required this.getAllProduct,
    required this.searchProductsUsecase,
    required this.sortProductsUsecase,
  }) : super(AllProductsInitial());

  Future<void> fetchAllProducts() async {
    state = AllProductsLoading();
    try {
      final allProducts = await getAllProduct();
      state = AllProductsLoaded(allProducts);
    } catch (e) {
      state = AllProductsError(e.toString());
    }
  }

  Future<void> searchProducts({required String word}) async {
    state = AllProductsLoading();
    try {
      final searchProducts = await searchProductsUsecase(word: word);
      state = AllProductsLoaded(searchProducts);
    } catch (e) {
      state = AllProductsError(e.toString());
    }
  }

  Future<void> sortProducts(
      {required String sortName, required String ascDesc}) async {
    state = AllProductsInitial();
    try {
      final sortProducts =
          await sortProductsUsecase(sortName: sortName, ascDesc: ascDesc);
      state = AllProductsLoaded(sortProducts);
    } catch (e) {
      state = AllProductsError(e.toString());
    }
  }
}

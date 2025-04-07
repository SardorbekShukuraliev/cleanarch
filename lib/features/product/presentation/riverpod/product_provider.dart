import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cleanarch/features/product/domain/usecases/get_all_products_usecase.dart';
import 'package:cleanarch/features/product/domain/usecases/search_products_usecase.dart';
import 'package:cleanarch/features/product/domain/usecases/sort_products_usecase.dart';
import 'package:cleanarch/features/product/presentation/riverpod/all_products/all_products_notifier.dart';
import 'package:cleanarch/features/product/presentation/riverpod/all_products/all_products_state.dart';
import 'package:cleanarch/features/product/presentation/riverpod/single_product/product_notifier.dart';
import '../../data/datasources/product_remote_data_source.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/get_product_usecase.dart';
import 'single_product/product_state.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final productRemoteDataSourceProvider =
    Provider<ProductRemoteDataSource>((ref) {
  return ProductRemoteDataSourceImpl(dio: ref.watch(dioProvider));
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(ref.watch(productRemoteDataSourceProvider));
});

final getProductUseCaseProvider = Provider<ProductUseCase>((ref) {
  return ProductUseCase(ref.watch(productRepositoryProvider));
});

final getAllProductsUseCaseProvider = Provider<GetAllProductsUsecase>((ref) {
  return GetAllProductsUsecase(ref.watch(productRepositoryProvider));
});
final searchAllProductsUseCaseProvider = Provider<SearchProductsUsecase>((ref) {
  return SearchProductsUsecase(ref.watch(productRepositoryProvider));
});

final sortAllProductUseCaseProvider = Provider<SortProductsUsecase>((ref) {
  return SortProductsUsecase(ref.watch(productRepositoryProvider));
});

final productProvider =
    StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  return ProductNotifier(ref.watch(getProductUseCaseProvider));
});

final allProductsProvider =
    StateNotifierProvider<AllProductsNotifier, AllProductsState>((ref) {
  return AllProductsNotifier(
    getAllProduct: ref.watch(getAllProductsUseCaseProvider),
    searchProductsUsecase: ref.watch(searchAllProductsUseCaseProvider),
    sortProductsUsecase: ref.watch(sortAllProductUseCaseProvider),
  );
});

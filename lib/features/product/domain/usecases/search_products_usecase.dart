import 'package:cleanarch/features/product/domain/entities/all_products.dart';
import '../repositories/product_repository.dart';

class SearchProductsUsecase {
  final ProductRepository repository;

  SearchProductsUsecase(this.repository);

  Future<AllProducts> call({required String word}) {
    return repository.searchProducts(word: word);
  }
}

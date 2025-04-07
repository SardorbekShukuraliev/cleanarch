import 'package:cleanarch/features/product/domain/entities/all_products.dart';
import '../repositories/product_repository.dart';

class SortProductsUsecase {
  final ProductRepository repository;

  SortProductsUsecase(this.repository);

  Future<AllProducts> call(
      {required String sortName, required String ascDesc}) {
    return repository.sortProducts(sortName: sortName, ascDesc: ascDesc);
  }
}

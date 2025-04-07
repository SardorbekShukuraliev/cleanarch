import 'package:cleanarch/features/product/domain/entities/all_products.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Product> getSingleProduct({required int id}) {
    return remoteDataSource.getSingleProduct(id: id);
  }

  @override
  Future<AllProducts> getAllProducts() {
    return remoteDataSource.getAllProduct();
  }

  @override
  Future<AllProducts> searchProducts({required String word}) {
    return remoteDataSource.searchProducts(word: word);
  }

  @override
  Future<AllProducts> sortProducts(
      {required String sortName, required String ascDesc}) {
    return remoteDataSource.sortProducts(sortName: sortName, ascDesc: ascDesc);
  }
}

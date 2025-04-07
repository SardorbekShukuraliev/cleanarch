import 'package:cleanarch/features/product/domain/entities/all_products.dart';

import '../entities/product.dart';

abstract class ProductRepository {
  Future<Product> getSingleProduct({required int id});

  Future<AllProducts> getAllProducts();

  Future<AllProducts> searchProducts({required String word});

  Future<AllProducts> sortProducts(
      {required String sortName, required String ascDesc});
}

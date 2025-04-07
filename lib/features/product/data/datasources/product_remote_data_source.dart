import 'package:dio/dio.dart';

import '../models/all_products_model.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> getSingleProduct({required int id});

  Future<AllProductsModel> getAllProduct();

  Future<AllProductsModel> searchProducts({required String word});

  Future<AllProductsModel> sortProducts(
      {required String sortName, required String ascDesc});
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<ProductModel> getSingleProduct({required int id}) async {
    final response = await dio.get(
      'https://dummyjson.com/products/$id',
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ProductModel.fromJson(response.data);
    } else {
      throw Exception('Failed to get single product');
    }
  }

  @override
  Future<AllProductsModel> getAllProduct() async {
    final response = await dio.get('https://dummyjson.com/products');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return AllProductsModel.fromJson(response.data);
    } else {
      throw Exception('Failed to get all products');
    }
  }

  @override
  Future<AllProductsModel> searchProducts({required String word}) async {
    final response =
    await dio.get('https://dummyjson.com/products/search?q=$word');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return AllProductsModel.fromJson(response.data);
    } else {
      throw Exception('Failed to get all products');
    }
  }

  @override
  Future<AllProductsModel> sortProducts(
      {required String sortName, required String ascDesc}) async {
    final response = await dio
        .get('https://dummyjson.com/products?sortBy=$sortName&order=$ascDesc');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return AllProductsModel.fromJson(response.data);
    } else {
      throw Exception('Failed to sort');
    }
  }
}

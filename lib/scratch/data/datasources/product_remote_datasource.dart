import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../../core/exceptions/app_exception.dart';
import '../models/product_model.dart';

abstract interface class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio _dio;

  const ProductRemoteDataSourceImpl(this._dio);

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await _dio.get(ApiConstants.products);
    if (response.statusCode != 200) {
      throw ServerException(
        statusCode: response.statusCode!,
        message: 'Failed to fetch products',
      );
    }
    return (response.data as List)
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    final response = await _dio.get(ApiConstants.productById(id));
    if (response.statusCode != 200) {
      throw ServerException(
        statusCode: response.statusCode!,
        message: 'Failed to fetch product',
      );
    }
    return ProductModel.fromJson(response.data as Map<String, dynamic>);
  }
}

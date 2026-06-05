import 'package:dio/dio.dart';

import '../../core/exceptions/app_exception.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _dataSource;

  const ProductRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<ProductEntity>>> getProducts() async {
    try {
      final models = await _dataSource.getProducts();
      return Success(models.map((m) => m.toEntity()).toList());
    } on DioException catch (e) {
      return Failure(NetworkException(e.message ?? 'Network error'));
    } on AppException catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(AppException(e.toString()));
    }
  }

  @override
  Future<Result<ProductEntity>> getProductById(int id) async {
    try {
      final model = await _dataSource.getProductById(id);
      return Success(model.toEntity());
    } on DioException catch (e) {
      return Failure(NetworkException(e.message ?? 'Network error'));
    } on AppException catch (e) {
      return Failure(e);
    } catch (e) {
      return Failure(AppException(e.toString()));
    }
  }
}

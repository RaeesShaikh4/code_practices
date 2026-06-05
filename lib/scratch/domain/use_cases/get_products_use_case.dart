import '../../core/utils/result.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository _repository;

  const GetProductsUseCase(this._repository);

  Future<Result<List<ProductEntity>>> call() => _repository.getProducts();
}

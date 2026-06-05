import '../../core/utils/result.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductByIdUseCase {
  final ProductRepository _repository;

  const GetProductByIdUseCase(this._repository);

  Future<Result<ProductEntity>> call(int id) =>
      _repository.getProductById(id);
}

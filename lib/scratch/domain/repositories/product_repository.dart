import '../../core/utils/result.dart';
import '../entities/product_entity.dart';

// Abstract contract — data layer must implement this
abstract interface class ProductRepository {
  Future<Result<List<ProductEntity>>> getProducts();
  Future<Result<ProductEntity>> getProductById(int id);
}

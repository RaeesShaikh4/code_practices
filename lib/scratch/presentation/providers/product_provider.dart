import 'package:flutter/foundation.dart';

import '../../core/utils/result.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/use_cases/get_product_by_id_use_case.dart';
import '../../domain/use_cases/get_products_use_case.dart';

enum ProductStatus { initial, loading, loaded, error }

class ProductProvider extends ChangeNotifier {
  final GetProductsUseCase _getProductsUseCase;
  final GetProductByIdUseCase _getProductByIdUseCase;

  ProductProvider({
    required GetProductsUseCase getProductsUseCase,
    required GetProductByIdUseCase getProductByIdUseCase,
  })  : _getProductsUseCase = getProductsUseCase,
        _getProductByIdUseCase = getProductByIdUseCase;

  List<ProductEntity> _products = [];
  ProductEntity? _selectedProduct;
  ProductStatus _status = ProductStatus.initial;
  String? _errorMessage;

  List<ProductEntity> get products => _products;
  ProductEntity? get selectedProduct => _selectedProduct;
  ProductStatus get status => _status;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == ProductStatus.loading;

  Future<void> fetchProducts() async {
    _status = ProductStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _getProductsUseCase();

    // Exhaustive switch — compiler enforces all cases (sealed class)
    switch (result) {
      case Success<List<ProductEntity>>():
        _products = result.data;
        _status = ProductStatus.loaded;
      case Failure<List<ProductEntity>>():
        _errorMessage = result.exception.message;
        _status = ProductStatus.error;
    }
    notifyListeners();
  }

  Future<void> fetchProductById(int id) async {
    _status = ProductStatus.loading;
    _errorMessage = null;
    _selectedProduct = null;
    notifyListeners();

    final result = await _getProductByIdUseCase(id);

    switch (result) {
      case Success<ProductEntity>():
        _selectedProduct = result.data;
        _status = ProductStatus.loaded;
      case Failure<ProductEntity>():
        _errorMessage = result.exception.message;
        _status = ProductStatus.error;
    }
    notifyListeners();
  }
}

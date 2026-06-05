import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../core/constants/api_constants.dart';
import '../data/datasources/product_remote_datasource.dart';
import '../data/repositories/product_repository_impl.dart';
import '../domain/repositories/product_repository.dart';
import '../domain/use_cases/get_product_by_id_use_case.dart';
import '../domain/use_cases/get_products_use_case.dart';
import '../presentation/providers/product_provider.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ── Network ──────────────────────────────────────────────────────
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
    ));
    return dio;
  });

  // ── Data sources ─────────────────────────────────────────────────
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl()),
  );

  // ── Repositories ─────────────────────────────────────────────────
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );

  // ── Use cases ────────────────────────────────────────────────────
  sl.registerLazySingleton(() => GetProductsUseCase(sl()));
  sl.registerLazySingleton(() => GetProductByIdUseCase(sl()));

  // ── Providers (factory so each screen gets a fresh instance) ─────
  sl.registerFactory(
    () => ProductProvider(
      getProductsUseCase: sl(),
      getProductByIdUseCase: sl(),
    ),
  );
}

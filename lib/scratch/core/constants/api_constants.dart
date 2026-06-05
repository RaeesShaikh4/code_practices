class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://fakestoreapi.com';
  static const String products = '/products';
  static String productById(int id) => '/products/$id';
}

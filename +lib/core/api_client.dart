import 'package:dio/dio.dart';

class ApiClient {
  static final dio = Dio(
    BaseOptions(
      baseUrl: 'https://your-api-url.com',
      connectTimeout: const Duration(seconds: 10),
    ),
  );
}

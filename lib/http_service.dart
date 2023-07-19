import 'package:dio/dio.dart';

class HttpService {
  Dio client() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://cbu.uz',
        connectTimeout: const Duration(seconds: 60),
      ),
    );
    return dio;
  }
}

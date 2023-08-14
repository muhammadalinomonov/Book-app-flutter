import 'package:dio/dio.dart';

class BaseApi {
  final _dio = Dio(
    BaseOptions(
        baseUrl: "https://run.mocky.io/v3/", validateStatus: (status) => true),
  );

  Dio get dio => _dio;
}

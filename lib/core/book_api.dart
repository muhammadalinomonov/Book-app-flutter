import 'package:book_app/data/model/BookModel.dart';
import 'package:dio/dio.dart';

class BookApi {

  final _dio = Dio(BaseOptions(
    baseUrl: "https://run.mocky.io/v3/",
    validateStatus: (status) => true,
  ));

  Future<List<BookModel>> getList() async {
    final response = await _dio.get("5c9ffd1e-671c-4a53-8fb4-2139d9f77ac2");

    return (response.data["books"] as List)
        .map((bookData) => BookModel.fromJson(bookData))
        .toList();
  }

  Future<BookModel> getDetails(String id) async {
    final response = await _dio.get(id);
    return BookModel.fromJson(response.data);
  }
}
mixin BookApi2{
  Future<List<BookModel>> getList();
  Future<BookModel> getDetails(String id);
}
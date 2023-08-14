import 'package:book_app/core/book_api.dart';
import 'package:book_app/data/model/BookModel.dart';
import 'package:dio/dio.dart';

class BookApiImpl implements BookApi2 {
  final Dio _dio;

  BookApiImpl(this._dio);

  @override
  Future<BookModel> getDetails(String id) async {
    final response = await _dio.get(id);
    return BookModel.fromJson(response.data);
  }

  @override
  Future<List<BookModel>> getList() async {
    final response = await _dio.get("1d5d1164-0961-45a9-bb55-f12c7708000e");

    return (response.data["books"] as List)
        .map((e) => BookModel.fromJson(e))
        .toList();
  }
}

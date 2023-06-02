import 'package:dio/dio.dart';

abstract class ContentApi {
  Future<Response> getFeed(String url);
}

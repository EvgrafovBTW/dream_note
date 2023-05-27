import 'package:dio/dio.dart';
import 'package:dream_note/logic/api/common_api/common_api.dart';
import 'package:flutter/material.dart';

class CommonApiImpl extends CommonApi {
  Dio dio = Dio();
  static final CommonApiImpl _commonApi = CommonApiImpl._internal();
  CommonApiImpl._internal() {
    //TODO не забыть поменять на адекватную ссылку на бекенд , когда появится
    dio.options.baseUrl = 'https://google.com';
  }
  factory CommonApiImpl() {
    return _commonApi;
  }

  @override
  Future<Response> get(
    String url, {
    required Options options,
    BuildContext? context,
  }) async {
    Response response = await dio.get(url);
    return response;
  }
}

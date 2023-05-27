import 'package:dio/dio.dart';
import 'package:dream_note/logic/api/common_api/common_api.dart';
import 'package:flutter/material.dart';

class CommonTestApiImpl extends CommonApi {
  Dio dio = Dio();
  static final CommonTestApiImpl _commonApi = CommonTestApiImpl._internal();
  CommonTestApiImpl._internal() {
    //TODO не забыть поменять на адекватную ссылку на бекенд , когда появится
    dio.options.baseUrl = 'https://google.com';
  }
  factory CommonTestApiImpl() {
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

import 'package:dio/dio.dart';
import 'package:dream_note/logic/api/content_api/content_api.dart';

import '../common_api_impl/common_api_impl.dart';

class ContentApiImpl extends ContentApi {
  final CommonApiImpl api = CommonApiImpl();

  @override
  Future<Response> getFeed(String url) async {
    Response response = await api.get(url, options: Options());
    return response;
  }
}

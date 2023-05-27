import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class CommonApi {
  Future<Response> get(
    String url, {
    required Options options,
    BuildContext? context,
  });
}

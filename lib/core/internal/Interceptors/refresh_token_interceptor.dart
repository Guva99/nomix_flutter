import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nomix/core/database/data/repositories/hivey.dart';
import 'package:nomix/core/database/hive_key_constants.dart';
import 'package:nomix/core/internal/reference_wrapper.dart';
import 'package:nomix/core/utils/get_it_utils.dart';

class RefreshTokenInterceptor extends Interceptor with HiveKeyConstants {
  RefreshTokenInterceptor({
    required this.token,
    // required this.refreshToken,
    required this.dio,
  });

  final ReferenceWrapper<String?>? token;

  final Dio? dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    HiveApp hive = HiveApp();

    final String token = await hive.getString(key: accessToken) ?? '';
    if (token != '') {
      GetItUtils.logger.f('ТОКЕН   $token');
      options.headers['authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    return handler.next(err);
  }
}

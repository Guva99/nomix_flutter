// import 'dart:async';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:wise_city_module_app/core/database/data/repositories/hivey.dart';
// import 'package:wise_city_module_app/core/database/hive_key_constants.dart';
// import 'package:wise_city_module_app/core/enum/refresh_token_result.dart';
// import 'package:wise_city_module_app/core/internal/reference_wrapper.dart';
// import 'package:wise_city_module_app/core/utils/get_it_utils.dart';
// import 'package:wise_city_module_app/general_src_logic/smart_house_src/data/model/auth_data_model.dart';
//
// class RefreshTokenInterceptor extends Interceptor with HiveKeyConstants {
//   RefreshTokenInterceptor({
//     required this.token,
//     // required this.refreshToken,
//     required this.dio,
//     required this.refreshTokenStatusCallback,
//   });
//
//   final ReferenceWrapper<JwtTokensModel?>? token;
//
//   // final Future<RefreshTokenResult?>? Function({bool? forceRefresh})
//   // refreshToken;
//   final Dio? dio;
//   final Function(RefreshTokenResult)? refreshTokenStatusCallback;
//   bool _isRefreshing = false;
//   Completer<void>? _refreshCompleter;
//
//   @override
//   Future<void> onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     HiveApp hive = HiveApp();
//     // final dynamic refreshTokenResult = await refreshToken();
//
//     final String token = await hive.getString(key: accessToken) ?? '';
//     if (token != '') {
//       GetItUtils.logger.f('ТОКЕН АКТИВЕН $token');
//
//       options.headers['authorization'] = 'Bearer $token';
//     }
//
//     // if (token?.value?.refreshTokenExpiresAt == true || token == null) {
//     //   _isRefreshing = true;
//     //   _refreshCompleter = Completer();
//     //
//     //   try {
//     //     if (refreshTokenResult != null && refreshTokenResult is DioException) {
//     //       _isRefreshing = false;
//     //       _refreshCompleter?.complete();
//     //       return handler.reject(refreshTokenResult);
//     //     } else if (refreshTokenResult == RefreshTokenResult.success) {
//     //     } else {
//     //       _isRefreshing = false;
//     //       _refreshCompleter?.complete();
//     //       return handler.reject(
//     //         DioException(
//     //           requestOptions: options,
//     //           error: 'Failed to refresh token',
//     //         ),
//     //       );
//     //     }
//     //   } catch (e) {
//     //     _isRefreshing = false;
//     //     _refreshCompleter?.complete();
//     //     rethrow;
//     //   }
//     //
//     //   _isRefreshing = false;
//     //   _refreshCompleter?.complete();
//     // }
//
//     // if (token?.value?.authToken != null) {
//     //   options.headers['authorization'] = 'Bearer ${token?.value?.authToken}';
//     // }
//
//     return handler.next(options);
//   }
//
//   @override
//   Future<void> onError(
//     DioException err,
//     ErrorInterceptorHandler handler,
//   ) async {
//     // debugPrint('err: $err');
//     // final Response<dynamic>? response = err.response;
//     // if (response == null || token == null || !(response.statusCode == 401)) {
//     //   GetItUtils.logger.e(err);
//     //   return handler.next(err);
//     // }
//     //
//     // if (response.statusCode == 401 || response.statusCode == 403) {
//     //   refreshTokenStatusCallback?.call(RefreshTokenResult.expired);
//     // }
//     //
//     // if (_isRefreshing) {
//     //   await _refreshCompleter?.future;
//     // } else {
//     //   _isRefreshing = true;
//     //   _refreshCompleter = Completer();
//     //
//     //   try {
//     //     final dynamic refreshTokenResult = await refreshToken();
//     //
//     //     if (refreshTokenResult == RefreshTokenResult.success) {
//     //       final JwtTokensModel? newToken = token?.value;
//     //       err.requestOptions.headers['authorization'] =
//     //           'Bearer ${newToken?.authToken}';
//     //       _isRefreshing = false;
//     //       _refreshCompleter?.complete();
//     //       return handler.resolve(await dio!.fetch(err.requestOptions));
//     //     } else if (refreshTokenResult != null &&
//     //         refreshTokenResult is DioException) {
//     //       _isRefreshing = false;
//     //       _refreshCompleter?.complete();
//     //       return handler.next(refreshTokenResult);
//     //     } else {
//     //       _isRefreshing = false;
//     //       _refreshCompleter?.complete();
//     //       return handler.next(err);
//     //     }
//     //   } catch (e) {
//     //     GetItUtils.logger.e('Error Token: $e');
//     //     _isRefreshing = false;
//     //     _refreshCompleter?.complete();
//     //     rethrow;
//     //   }
//     // }
//
//     return handler.next(err);
//   }
// }

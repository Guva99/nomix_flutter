import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:nomix/core/database/data/repositories/hivey.dart';
import 'package:nomix/core/internal/sl.config.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

final getIt = GetIt.instance;
Completer<bool>? setupCompleter;

@InjectableInit(initializerName: r'$initGetIt', preferRelativeImports: true, asExtension: false)
void configureDependencies() => $initGetIt(getIt);

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio {
    Dio dio = Dio(
      BaseOptions(
        // baseUrl: 'https://wisecity.systems/api/execute/',
        // baseUrl: 'https://dev.wisecity.systems/api/execute/',
        baseUrl:  '',
        connectTimeout: const Duration(milliseconds: 35000),
      ),
    );
    // dio.interceptors.add(
    //   RefreshTokenInterceptor(
    //     token: _token,
    //     // refreshToken: refreshToken,
    //     dio: dio,
    //     refreshTokenStatusCallback: (RefreshTokenResult refreshTokenResult) {
    //       _refreshTokenStreamController.add(refreshTokenResult);
    //     },
    //   ),
    // );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          options.headers.addAll(<String, dynamic>{'Content-Type': 'application/json'});
          return handler.next(options);
        },
      ),
    );

    dio.interceptors.add(
      TalkerDioLogger(
        talker: getIt<Talker>(),
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseMessage: true,
          printRequestData: true,
          printResponseData: true,
          printErrorData: true,
        ),
      ),
    );
    return dio;
  }

  @lazySingleton
  HiveApp hivey() {
    return HiveApp();
  }

  // @lazySingleton
  // SmartHouseApi generalNewsApi() => SmartHouseNetworkService(dio);
}

//
// Future<RefreshTokenResult?> refreshToken({bool? forceRefresh}) async {
//   final authRepo = AuthDataRepositoryImpl();
//   await setupComplete();
//
//   try {
//     final JwtTokensModel? tokens = await authRepo.getTokenAccess();
//
//     if (tokens == null) {
//       _refreshTokenStreamController.add(RefreshTokenResult.noToken);
//       return RefreshTokenResult.noToken;
//     }
//
//     // Сохраняем текущие токены в стейт
//     _token.value = tokens;
//
//     // Время истечения токена (уже DateTime)
//     final DateTime expiresAt = tokens.authTokenExpiresAt;
//     final DateTime nowUtc    = DateTime.now().toUtc();
//
//     // Сколько осталось до истечения
//     final Duration timeLeft = expiresAt.difference(nowUtc);
//
//     // Если осталось ≤ 1 дня или принудительный апдейт
//     if (timeLeft <= const Duration(days: 1) || forceRefresh == true) {
//       GetItUtils.logger.i(
//           'Токен истекает через ${timeLeft.inHours} ч. (${expiresAt.toIso8601String()}), обновляем…'
//       );
//
//       // final int? statusCode = await requestNewToken(tokens);
//       // if (statusCode == null) {
//       //   _refreshTokenStreamController.add(RefreshTokenResult.serverUnavailable);
//       //   return RefreshTokenResult.serverUnavailable;
//       // }
//       // if (statusCode >= 200 && statusCode < 300) {
//       //   _refreshTokenStreamController.add(RefreshTokenResult.success);
//       //   return RefreshTokenResult.success;
//       // }
//       // if (statusCode == 401 || statusCode == 403) {
//       //   _refreshTokenStreamController.add(RefreshTokenResult.expired);
//       //   return RefreshTokenResult.expired;
//       // }
//     }
//
//     // Пока ещё больше суток до конца
//     _refreshTokenStreamController.add(RefreshTokenResult.stillValid);
//     refreshCompleter?.complete(true);
//     return RefreshTokenResult.stillValid;
//
//   } catch (e) {
//     if (e is DioException) {
//       final code = e.response?.statusCode ?? 0;
//       if (code == 401 || code == 403) {
//         _refreshTokenStreamController.add(RefreshTokenResult.expired);
//         return RefreshTokenResult.expired;
//       }
//       if (code >= 500 && code < 600) {
//         _refreshTokenStreamController.add(RefreshTokenResult.serverUnavailable);
//         return RefreshTokenResult.serverUnavailable;
//       }
//     }
//     refreshCompleter?.complete(false);
//     rethrow;
//   }
// }
//
//
// Future<bool?> setupComplete() async {
//   return setupCompleter?.future;
// }

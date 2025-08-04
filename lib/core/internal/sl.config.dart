// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/web.dart' as _i120;

import '../../features/app/data/data_source/api/app_page_api.dart' as _i856;
import '../../features/app/data/data_source/services/app_page_api_service.dart'
    as _i902;
import '../../features/app/data/repository/app_page_repository_impl.dart'
    as _i208;
import '../../features/app/domain/repository/app_page_repository.dart' as _i685;
import '../../features/app/domain/usecases/usecase.dart' as _i332;
import '../../features/app/state/app_page_bloc.dart' as _i287;
import '../../features/approve_receipts_page/data/repository/home_page_repository_impl.dart'
    as _i366;
import '../../features/approve_receipts_page/data/source/api/approve_receipts_page_api.dart'
    as _i729;
import '../../features/approve_receipts_page/data/source/services/approve_receipts_page_api_service.dart'
    as _i16;
import '../../features/approve_receipts_page/domain/repository/approve_receipts_page_repository.dart'
    as _i903;
import '../../features/approve_receipts_page/domain/usecases/usecase.dart'
    as _i778;
import '../../features/approve_receipts_page/ui/state/approve_reciepts_bloc.dart'
    as _i96;
import '../../features/detail_statistic_page/ui/state/detail_statistic_bloc.dart'
    as _i829;
import '../../features/home_page/data/data_source/api/home_page_api.dart'
    as _i383;
import '../../features/home_page/data/data_source/services/home_page_api_service.dart'
    as _i495;
import '../../features/home_page/data/repository/home_page_repository_impl.dart'
    as _i64;
import '../../features/home_page/domain/repository/home_page_repository.dart'
    as _i814;
import '../../features/home_page/domain/usecases/usecase.dart' as _i1006;
import '../../features/home_page/ui/state/home_page_bloc.dart' as _i170;
import '../database/data/repositories/hivey.dart' as _i407;
import 'logger_di_module.dart' as _i1018;
import 'sl.dart' as _i581;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  final loggerDiModule = _$LoggerDiModule();
  gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
  gh.lazySingleton<_i407.HiveApp>(() => registerModule.hivey());
  gh.lazySingleton<_i383.HomePageApi>(() => registerModule.homePageApi());
  gh.lazySingleton<_i856.AppPageApi>(() => registerModule.appPageApi());
  gh.lazySingleton<_i729.ApproveReceiptsApi>(
      () => registerModule.generalNewsApi());
  gh.lazySingleton<_i120.Logger>(() => loggerDiModule.logger);
  gh.lazySingleton<_i829.DetailStatisticBloc>(
      () => _i829.DetailStatisticBloc());
  gh.lazySingleton<_i495.HomePageApiService>(
      () => _i495.HomePageApiService(gh<_i361.Dio>()));
  gh.lazySingleton<_i16.ApproveReceiptsApiService>(
      () => _i16.ApproveReceiptsApiService(gh<_i361.Dio>()));
  gh.lazySingleton<_i902.AppPageApiService>(
      () => _i902.AppPageApiService(gh<_i361.Dio>()));
  gh.lazySingleton<_i903.ApproveReceiptsRepository>(() =>
      _i366.ApproveReceiptsRepositoryImpl(
          approveReceiptsApiService: gh<_i16.ApproveReceiptsApiService>()));
  gh.lazySingleton<_i814.HomePageRepository>(() => _i64.HomePageRepositoryImpl(
      authServiceApi: gh<_i495.HomePageApiService>()));
  gh.lazySingleton<_i778.ApproveReceiptsUseCase>(() =>
      _i778.ApproveReceiptsUseCase(
          approveReceiptsRepository: gh<_i903.ApproveReceiptsRepository>()));
  gh.lazySingleton<_i685.AppPageRepository>(() => _i208.AppPageRepositoryImpl(
      authServiceApi: gh<_i902.AppPageApiService>()));
  gh.lazySingleton<_i332.AppPageUseCase>(() =>
      _i332.AppPageUseCase(appPageRepository: gh<_i685.AppPageRepository>()));
  gh.lazySingleton<_i1006.HomePageUseCase>(() => _i1006.HomePageUseCase(
      homePageRepository: gh<_i814.HomePageRepository>()));
  gh.lazySingleton<_i96.ApproveReceiptsBloc>(
      () => _i96.ApproveReceiptsBloc(gh<_i778.ApproveReceiptsUseCase>()));
  gh.lazySingleton<_i287.AppPageBloc>(
      () => _i287.AppPageBloc(gh<_i332.AppPageUseCase>()));
  gh.lazySingleton<_i170.HomePageBloc>(
      () => _i170.HomePageBloc(gh<_i1006.HomePageUseCase>()));
  return getIt;
}

class _$RegisterModule extends _i581.RegisterModule {}

class _$LoggerDiModule extends _i1018.LoggerDiModule {}

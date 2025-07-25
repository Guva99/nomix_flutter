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
  gh.lazySingleton<_i383.HomePageApi>(() => registerModule.generalNewsApi());
  gh.lazySingleton<_i120.Logger>(() => loggerDiModule.logger);
  gh.lazySingleton<_i829.DetailStatisticBloc>(
      () => _i829.DetailStatisticBloc());
  gh.lazySingleton<_i495.HomePageApiService>(
      () => _i495.HomePageApiService(gh<_i361.Dio>()));
  gh.lazySingleton<_i814.HomePageRepository>(() => _i64.HomePageRepositoryImpl(
      authServiceApi: gh<_i495.HomePageApiService>()));
  gh.lazySingleton<_i1006.HomePageUseCase>(() => _i1006.HomePageUseCase(
      homePageRepository: gh<_i814.HomePageRepository>()));
  gh.lazySingleton<_i170.HomePageBloc>(
      () => _i170.HomePageBloc(gh<_i1006.HomePageUseCase>()));
  return getIt;
}

class _$RegisterModule extends _i581.RegisterModule {}

class _$LoggerDiModule extends _i1018.LoggerDiModule {}

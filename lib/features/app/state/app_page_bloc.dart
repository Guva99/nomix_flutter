import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:nomix/core/entity/auth_data_entity.dart';
import 'package:nomix/core/repositories/auth_data_repository_impl.dart';
import 'package:nomix/core/utils/get_it_utils.dart';
import 'package:nomix/core/service/telegram_service/telegram_utils.dart';
import 'package:nomix/features/app/domain/usecases/usecase.dart';
import 'package:nomix/features/home_page/domain/entity/auth_data_entity.dart';
import 'package:nomix/features/home_page/domain/usecases/usecase.dart';

part 'app_page_event.dart';

part 'app_page_state.dart';

@lazySingleton
class AppPageBloc extends Bloc<AppPageEvent, AppPageState> {
  final AppPageUseCase appPageUseCase;

  AppPageBloc(this.appPageUseCase) : super(HomePageInitial()) {
    on<AuthGetDataEvent>(_onAuthGetDataEvent);
  }

  Future<void> _onAuthGetDataEvent(
    AuthGetDataEvent event,
    Emitter<AppPageState> emit,
  ) async {
    AuthDataEntity? data;

    AuthDataRepositoryImpl authDataRepositoryImpl = AuthDataRepositoryImpl();
    final AuthUserEntity? dataTelegram = TelegramUtils.getUserInfo();

    if (dataTelegram != null) {
      data = await appPageUseCase.addUserTelegram(
        id: dataTelegram.id!,
        firstName: dataTelegram.firstName,
        lastName: dataTelegram.lastName,
        username: dataTelegram.username,
        photoUrl: dataTelegram.photoUrl,
      );
    }
    authDataRepositoryImpl.saveTokenAccess(data?.token ?? '');
    emit(
      AuthUserDataTelegramState(
        authUserEntity: AuthUserEntity(
          firstName: dataTelegram?.firstName ?? '',
          lastName: dataTelegram?.lastName ?? '',
          username: dataTelegram?.username ?? '',
          id: data?.id,
          photoUrl: data?.photoUrl,
        ),
      ),
    );
    GetItUtils.logger.w('Из БЭКА ФОТО:${data?.photoUrl}');
    // await checkStatusAndGetNewDataSensor(generalResponseData: data, emit: emit, flatData: event.flatData);
  }
}

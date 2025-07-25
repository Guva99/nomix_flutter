import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:nomix/core/entity/auth_data_entity.dart';
import 'package:nomix/core/utils/telegram_utils.dart';
import 'package:nomix/features/home_page/domain/usecases/usecase.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

@lazySingleton
class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final HomePageUseCase homePageUseCase;

  HomePageBloc(this.homePageUseCase) : super(HomePageInitial()) {
    on<AuthGetDataEvent>(_onAuthGetDataEvent);
  }

  Future<void> _onAuthGetDataEvent(
    AuthGetDataEvent event,
    Emitter<HomePageState> emit,
  ) async {
    final data = TelegramUtils.getUserInfo();
    emit(AuthUserDataTelegramState(authUserEntity: data));

    // await checkStatusAndGetNewDataSensor(generalResponseData: data, emit: emit, flatData: event.flatData);
  }
}

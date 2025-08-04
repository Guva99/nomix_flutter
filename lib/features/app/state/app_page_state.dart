part of 'app_page_bloc.dart';

@immutable
sealed class AppPageState {
  const AppPageState();
}

final class HomePageInitial extends AppPageState {}

final class AuthUserDataTelegramState extends AppPageState {
  final AuthUserEntity? authUserEntity;

  const AuthUserDataTelegramState({this.authUserEntity});
}

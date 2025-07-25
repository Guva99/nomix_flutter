part of 'home_page_bloc.dart';

@immutable
sealed class HomePageState {
  const HomePageState();
}

final class HomePageInitial extends HomePageState {}

final class AuthUserDataTelegramState extends HomePageState {
  final AuthUserEntity? authUserEntity;

  const AuthUserDataTelegramState({this.authUserEntity});
}

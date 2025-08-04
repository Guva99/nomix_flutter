part of 'app_page_bloc.dart';

@immutable
sealed class AppPageEvent {
  const AppPageEvent();
}

class AuthGetDataEvent extends AppPageEvent {
  const AuthGetDataEvent( );

}

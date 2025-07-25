part of 'home_page_bloc.dart';

@immutable
sealed class HomePageEvent {
  const HomePageEvent();
}

class AuthGetDataEvent extends HomePageEvent {
  const AuthGetDataEvent( );

}

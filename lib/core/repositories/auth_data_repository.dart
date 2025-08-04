
abstract interface class AuthDataRepository {
  Future<String?> getTokenAccess();

  Future<void> deleteTokenAccess();


  void saveTokenAccess(String token);


}

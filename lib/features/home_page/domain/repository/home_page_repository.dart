abstract class HomePageRepository {
  Future<void> addUserTelegram({
    required int id,
    required String token,
    String? firstName,
    String? lastName,
    String? username,
    String? photoUrl,
  });
}

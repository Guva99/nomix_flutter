/// Enum результатов при обновлении токена или при получении нового
enum RefreshTokenResult {
  /// Успешно получен новый access token
  success,

  /// Refresh token устарел
  expired,

  /// Нет сохраненного OAuth2 токена
  noToken,

  /// Старый access токен всё еще валидный
  stillValid,

  /// Сервер недоступен
  serverUnavailable
}

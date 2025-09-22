class TelegramInitDataUnsafe {
  // Параметры, которые вы используете:
  final _User? user = null;
  final String? queryId = null;
}

/// Заглушка для самого WebApp
class TelegramWebApp {
  static TelegramWebApp get instance => TelegramWebApp();

  /// Всегда false на мобильных
  bool get isSupported => false;

  /// Возвращает заглушку InitData
  TelegramInitDataUnsafe? get initDataUnsafe => null;
}

/// Заглушка для HapticFeedback из пакета telegram_web_app
class HapticFeedback {
  static HapticFeedback get instance => HapticFeedback();
  void impactOccurred(dynamic _) {}
}

/// Enum, который есть в оригинальном пакете
enum HapticFeedbackImpact { light, medium, heavy }

/// Модель user-а из пакета
class _User {
  final int id = 0;
  final String? firstName = null;
  final String? lastName = null;
  final String? username = null;
  final String? photoUrl = null;
}
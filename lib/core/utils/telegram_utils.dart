import 'package:nomix/core/entity/auth_data_entity.dart';
import 'package:nomix/core/utils/get_it_utils.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

abstract class TelegramUtils {
  static AuthUserEntity? getUserInfo() {
    final telegramWebApp = TelegramWebApp.instance;

    if (telegramWebApp.isSupported) {
      final user = telegramWebApp.initDataUnsafe?.user;
      if (user == null) return null;

      GetItUtils.logger.w('WebAppUser:${user.username}==${user.photoUrl}==');

      return AuthUserEntity(
        id: user.id,
        firstName: user.firstName,
        lastName: user.lastName,
        username: user.username,
        photoUrl: user.photoUrl,
        token: telegramWebApp.initDataUnsafe?.queryId,
      );
    }
    return null;
  }
}

import 'package:flutter/services.dart';
import 'package:nomix/core/entity/auth_data_entity.dart';
import 'package:nomix/core/utils/get_it_utils.dart';

// import 'package:telegram_web_app/telegram_web_app.dart'
// if (dart.library.io) 'package:nomix/core/service/telegram_service/telegram_web_app_stub.dart'
// as tg;
import 'package:nomix/core/service/telegram_service/telegram_web_app_stub.dart'
    if (dart.library.html) 'package:telegram_web_app/telegram_web_app.dart' as tg;

abstract class TelegramUtils {
  static AuthUserEntity? getUserInfo() {
    final telegramWebApp = tg.TelegramWebApp.instance;

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

  static void startVibration() {
    final end = DateTime.now().add(const Duration(milliseconds: 800));
    // tg.TelegramWebApp и tg.HapticFeedback
    final useTelegram = tg.TelegramWebApp.instance.isSupported;
    final telegramHaptic = tg.HapticFeedback.instance;

    // без await, чтобы не блокировать анимацию
    () async {
      while (DateTime.now().isBefore(end)) {
        if (useTelegram) {
          telegramHaptic.impactOccurred(tg.HapticFeedbackImpact.light);
          telegramHaptic.impactOccurred(tg.HapticFeedbackImpact.medium);
          telegramHaptic.impactOccurred(tg.HapticFeedbackImpact.heavy);
        } else {
          // Flutter-фоллбэк
          await SystemChannels.platform.invokeMethod<void>(
            'HapticFeedback.mediumImpact',
          );
        }
        await Future.delayed(const Duration(milliseconds: 200));
      }
    }();
  }
}

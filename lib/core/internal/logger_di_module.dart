import 'package:injectable/injectable.dart';
import 'package:logger/web.dart';

@module
abstract class LoggerDiModule {
  @lazySingleton
  Logger get logger => Logger(
        printer: PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 5,
          lineLength: 120,
          colors: true,
          printEmojis: true,
        ),
      );
}

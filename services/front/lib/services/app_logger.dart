import 'package:logger/logger.dart';

class AppLogger {
  static final AppLogger instance = AppLogger._internal();
  late final Logger _logger;

  AppLogger._internal() {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 3,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        printTime: true,
      ),
      level: Level.debug, // Можно менять уровень логирования
    );
  }

  void d(String message) {
    String newMessage = '[DEBUG] $message';
    _logger.d(newMessage);
  }
}

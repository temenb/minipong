import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minipong/providers/environment_provider.dart';

class AppConfig {
  final String grpcHost;
  final int grpcPort;
  final Environment env;

  const AppConfig({
    required this.grpcHost,
    required this.grpcPort,
    required this.env,
  });

  bool get isProd => env == Environment.prod;
  bool get isDev => env == Environment.dev;
  bool get isStating => env == Environment.staging;

  @override
  String toString() => 'AppConfig(env: $env, host: $grpcHost, port: $grpcPort)';
}

final configProvider = Provider<AppConfig>((ref) {
  final env = ref.watch(environmentProvider);

  final host = dotenv.env['GATEWAY_HOST']?.trim();
  final portRaw = dotenv.env['GATEWAY_PORT']?.trim();

  final grpcHost = host?.isNotEmpty == true ? host! : 'localhost';
  final grpcPort = int.tryParse(portRaw ?? '') ?? 3000;

  return AppConfig(grpcHost: grpcHost, grpcPort: grpcPort, env: env);
});


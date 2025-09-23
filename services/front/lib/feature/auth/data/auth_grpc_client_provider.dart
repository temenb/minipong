import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';
import 'package:minipong/providers/config_provider.dart';
import 'package:minipong/src/grpc/generated/auth.pbgrpc.dart';

import 'auth_grpc_client.dart';

final authGrpcClientProvider = Provider<AuthGrpcClient>((ref) {
  final config = ref.watch(configProvider);
  final channel = ClientChannel(
    config.grpcHost,
    port: config.grpcPort,
    options: ChannelOptions(
      credentials: ChannelCredentials.insecure(),
      codecRegistry: CodecRegistry(codecs: [GzipCodec(), IdentityCodec()]),
    ),
  );

  final stub = AuthClient(channel);
  return AuthGrpcClient(stub);
});

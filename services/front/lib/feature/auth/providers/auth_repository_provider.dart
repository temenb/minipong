import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/auth_repository.dart';
import '../domain/auth_repository_grpc.dart';
import '../data/auth_grpc_client_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.read(authGrpcClientProvider);
  return AuthRepositoryGrpc(client);
});

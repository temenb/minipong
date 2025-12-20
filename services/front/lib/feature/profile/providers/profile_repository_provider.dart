import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/profile_repository.dart';
import '../domain/profile_repository_grpc.dart';
import '../data/profile_grpc_client_provider.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final client = ref.read(profileGrpcClientProvider);
  return ProfileRepositoryGrpc(client);
});

import 'package:minipong/src/grpc/generated/auth.pb.dart';
import './../data/auth_grpc_client.dart';
import './auth_repository.dart';
import './auth.dart';

class AuthRepositoryGrpc implements AuthRepository {
  final AuthGrpcClient client;

  AuthRepositoryGrpc(this.client);

  @override
  Future<Auth> login(String id) async {

    final AuthResponse response = await client.login(id);

    return Auth(
      id: response.id,
      accessToken: response.accessToken ?? '',
      refreshToken: response.refreshToken ?? '',
    );
  }
}

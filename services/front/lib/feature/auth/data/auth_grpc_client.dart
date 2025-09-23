import 'package:minipong/src/grpc/generated/auth.pbgrpc.dart';
import 'package:minipong/src/grpc/generated/common/empty.pb.dart';

class AuthGrpcClient {
  final AuthClient profileClient;

  AuthGrpcClient(this.profileClient);

  // Future<AuthResponse> view(String id) async {
  //   final request = ViewRequest()..id = id;
  //   final response = await profileClient.view(request);
  //   return response;
  // }
  //
  // Future<AuthListResponse> getAll() async {
  //   final response = await profileClient.getAll(Empty());
  //   return response;
  // }
}

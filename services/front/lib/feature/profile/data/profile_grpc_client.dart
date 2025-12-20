import 'package:minipong/src/grpc/generated/profile.pbgrpc.dart';
import 'package:minipong/src/grpc/generated/common/empty.pb.dart';

class ProfileGrpcClient {
  final ProfileClient profileClient;

  ProfileGrpcClient(this.profileClient);

  Future<ProfileResponse> view(String id) async {
    final request = ViewRequest()..id = id;
    final response = await profileClient.view(request);
    return response;
  }

  Future<ProfileListResponse> getAll() async {
    final response = await profileClient.getAll(Empty());
    return response;
  }
}

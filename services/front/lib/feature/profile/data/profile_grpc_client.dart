import 'package:minipong/src/grpc/generated/profile.pbgrpc.dart';
import 'package:minipong/src/grpc/generated/common/empty.pb.dart';

class ProfileGrpcClient {
  final ProfileClient stub;

  ProfileGrpcClient(this.stub);

  Future<ProfileResponse> view(String id) async {
    final request = ViewRequest()..id = id;
    return await stub.view(request);
  }

  Future<List<ProfileResponse>> getAll() async {
    final response = await stub.getAll(Empty());
    return response.profiles;
  }
}

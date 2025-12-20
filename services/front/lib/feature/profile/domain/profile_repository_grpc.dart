import 'package:minipong/src/grpc/generated/profile.pb.dart';
import './../data/profile_grpc_client.dart';
import './profile_repository.dart';
import './profile.dart';

class ProfileRepositoryGrpc implements ProfileRepository {
  final ProfileGrpcClient client;

  ProfileRepositoryGrpc(this.client);

  @override
  Future<Profile> getById(String id) async {

    final ProfileResponse response = await client.view(id);

    return Profile(
      id: response.id,
      ownerId: response.ownerId ?? '',
      nickname: response.nickname ?? '',
    );
  }

  @override
  Future<List<Profile>> getAll() async {
    final ProfileListResponse response = await client.getAll();
    return response.profiles.map((profile) => Profile(
      id: profile.id,
      ownerId: profile.ownerId ?? '',
      nickname: profile.nickname ?? '',
    )).toList();
  }
}

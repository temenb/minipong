import 'package:minipong/src/grpc/generated/profile.pb.dart';
import './../data/profile_grpc_client.dart';
import './profile_repository.dart';
import './profile.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileGrpcClient client;

  ProfileRepositoryImpl(this.client);

  @override
  Future<Profile> getById(String id) async {
    final ProfileResponse dto = await client.view(id);
    return Profile(
      id: dto.id,
      ownerId: dto.ownerId ?? '',
      nickname: dto.nickname ?? '',
    );
  }

  @override
  Future<List<Profile>> getAll() async {
    final List<ProfileResponse> dtos = await client.getAll();
    return dtos.map((dto) => Profile(
      id: dto.id,
      ownerId: dto.ownerId ?? '',
      nickname: dto.nickname ?? '',
    )).toList();
  }
}

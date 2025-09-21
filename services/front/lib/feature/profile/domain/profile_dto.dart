import 'package:minipong/src/grpc/generated/profile.pb.dart';

class ProfileDto {
  final String id;
  final String? ownerId;
  final String? nickname;

  ProfileDto({
    required this.id,
    this.ownerId,
    this.nickname,
  });

  factory ProfileDto.fromProto(ProfileResponse proto) {
    return ProfileDto(
      id: proto.id,
      ownerId: proto.ownerId,
      nickname: proto.hasNickname() ? proto.nickname : null,
    );
  }

  ProfileResponse toProto() {
    final proto = ProfileResponse()..id = id;
    if (ownerId != null) proto.ownerId = ownerId!;
    if (nickname != null) proto.nickname = nickname!;
    return proto;
  }
}

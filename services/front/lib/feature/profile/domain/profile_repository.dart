import './profile.dart';

abstract class ProfileRepository {
  Future<Profile> getById(String id);
  Future<List<Profile>> getAll();
}

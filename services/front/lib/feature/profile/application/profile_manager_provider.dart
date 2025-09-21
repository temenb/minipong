import 'package:flutter_riverpod/flutter_riverpod.dart';
import './../domain/profile.dart';
import './../domain/profile_repository.dart';
import './../domain/profile_repository_provider.dart';

final profileManagerProvider =
AsyncNotifierProvider<ProfileManager, List<Profile>>(ProfileManager.new);

class ProfileManager extends AsyncNotifier<List<Profile>> {
  late final ProfileRepository _repository;

  @override
  Future<List<Profile>> build() async {
    _repository = ref.read(profileRepositoryProvider);
    return await _repository.getAll();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.getAll());
  }

  Future<void> selectProfile(String id) async {
    final selected = await _repository.getById(id);
    // Можно сохранить в state или вызвать другой менеджер
    print('Selected profile: ${selected.nickname}');
  }
}

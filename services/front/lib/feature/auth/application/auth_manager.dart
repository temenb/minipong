import 'package:flutter_riverpod/flutter_riverpod.dart';
import './../domain/auth.dart';
import './../domain/auth_repository.dart';
import '../providers/auth_repository_provider.dart';

class AuthManager extends AsyncNotifier<List<Auth>> {
  late final AuthRepository _repository;

  @override
  Future<List<Auth>> build() async {
    _repository = ref.read(authRepositoryProvider);
    return await _repository.getAll();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.getAll());
  }

  Future<void> selectAuth(String id) async {
    final selected = await _repository.getById(id);
    // Можно сохранить в state или пробросить в другой менеджер
    print('Selected auth: ${selected.id}');
  }
}

class ProfileManager extends AsyncNotifier<List<Profile>> {
  late final ProfileRepository repository;

  @override
  Future<List<Profile>> build() async {
    repository = ref.read(profileRepositoryProvider);
    return await repository.getAll();
  }
}

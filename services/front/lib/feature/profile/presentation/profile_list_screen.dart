import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minipong/feature/profile/application/profile_manager_provider.dart';

class ProfileListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profiles = ref.watch(profileManagerProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Profiles')),
      body: profiles.when(
        data: (list) => ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, i) => ListTile(
            leading: CircleAvatar(child: Text(list[i].nickname.isNotEmpty ? list[i].nickname[0] : '?')),
            title: Text(list[i].nickname),
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

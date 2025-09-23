import 'package:flutter_riverpod/flutter_riverpod.dart';
import './../application/profile_manager.dart';
import './../domain/profile.dart';

final profileManagerProvider =
AsyncNotifierProvider<ProfileManager, List<Profile>>(ProfileManager.new);


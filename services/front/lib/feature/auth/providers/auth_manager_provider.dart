import 'package:flutter_riverpod/flutter_riverpod.dart';
import './../application/auth_manager.dart';

final authManagerProvider =
AsyncNotifierProvider<AuthManager, Auth>(AuthManager.new);

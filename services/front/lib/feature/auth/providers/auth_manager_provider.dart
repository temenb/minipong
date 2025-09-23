import 'package:flutter_riverpod/flutter_riverpod.dart';
import './../application/auth_manager.dart';
import './../domain/auth.dart';

final authManagerProvider =
AsyncNotifierProvider<AuthManager, List<Auth>>(AuthManager.new);


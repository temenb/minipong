import './auth.dart';

abstract class AuthRepository {
  Future<Auth> login(String id);
}

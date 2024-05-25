import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcloud/core/utils/local_storage.dart';

import '../services/auth_service.dart';

final authProvider = Provider<AuthProvider>((ref) {
  return AuthProvider(ref);
});

class AuthProvider {
  final Ref ref;
  AuthProvider(this.ref);
  late final _authService = ref.read(authServiceProvider);
  // bool get isAuthenticated => UserPreferences.instance.getToken() != '';
  bool get isAuthenticated => false;
  Future<void> login() async {
    try {
      final inputFormData = FormData.fromMap({'db': 'tabcom17', 'login': 'admin', 'password': 'quantri1*Tab'});
      await _authService.login(inputFormData);
      UserPreferences.instance.saveToken('token');
    } catch (e) {
      print(e);
    }
  }

  void logout() {
    UserPreferences.instance.clearAuth();
  }
}

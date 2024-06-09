import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcloud/core/utils/extension/common_function.dart';
import 'package:mcloud/core/utils/local_storage.dart';

import '../services/auth_service.dart';

final authProvider = Provider<AuthProvider>((ref) {
  return AuthProvider(ref);
});

class AuthProvider {
  final Ref ref;
  AuthProvider(this.ref);
  late final _authService = ref.read(authServiceProvider);
  bool get isAuthenticated => UserPreferences.instance.getToken() != '';
  // bool get isAuthenticated => false;
  Future<bool> login(BuildContext context, String username, String password) async {
    try {
      final inputFormData = FormData.fromMap({'db': 'tabcom17', 'login': username, 'password': password});
      final result = await _authService.login(inputFormData);
      UserPreferences.instance.saveToken(result.accessToken ?? '');
      UserPreferences.instance.saveUserId(result.uid ?? 0);
      return true;
    } on DioException catch (e) {
      CommonFunction.showSnackBar('Tài khoản hoặc mật khẩu không đúng', context, Colors.red);
      return false;
    } catch (e) {
      CommonFunction.showSnackBar('Tài khoản chưa được kích hoạt', context, Colors.red);
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      final result = await _authService.register({"name": name, "login": email, "password": password});
      if (result['result']['message'] == 'Email đã được đăng ký') {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      final result = await _authService.forgotPassword({"email": email});
      if (result['result']['message'] == 'Email không tồn tại') {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> resetPassword(String email, String otp, String newPassword) async {
    try {
      final result = await _authService.resetPassword({"email": email, "otp": otp, "new_password": newPassword});
      if (result['result']['message'] == 'Mã OTP không đúng') {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  void logout() {
    UserPreferences.instance.clearAuth();
  }
}

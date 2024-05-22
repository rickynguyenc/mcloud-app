import 'package:hooks_riverpod/hooks_riverpod.dart';

final authProvider = Provider<AuthProvider>((ref) {
  return AuthProvider();
});

class AuthProvider {}

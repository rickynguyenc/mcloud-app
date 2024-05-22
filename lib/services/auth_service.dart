import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/http.dart';

import '../core/app_dio.dart';
import '../models/auth_model.dart';
part 'auth_service.g.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref);
});

@RestApi()
abstract class AuthService {
  factory AuthService(Ref ref) => _AuthService(ref.read(dioProvider));
  @POST('/api/auth/token')
  Future<LoginResponse> login(@Body() FormData param);
}

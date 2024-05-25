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
  @POST('/api/oauth/token')
  Future<LoginResponse> login(@Body() FormData param);
  @POST('/api/res_users')
  Future<dynamic> register(@Body() Map<String, dynamic> data);
}

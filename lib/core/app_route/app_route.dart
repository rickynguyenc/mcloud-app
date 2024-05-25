import 'package:auto_route/auto_route.dart';
import 'package:mcloud/providers/authentication_provider.dart';
import 'package:mcloud/screens/home_screen.dart';
import '../../screens/authentication/forget_password_screen.dart';
import '../../screens/authentication/login_screen.dart';
import '../../screens/authentication/login_with_password_screen.dart';
import '../../screens/authentication/otp_confirm_screen.dart';
import '../../screens/authentication/register_screen.dart';
import '../../screens/authentication/reset_password_screen.dart';
import '../../screens/authentication/welcome_screen.dart';
import 'app_route_guard.dart';
part 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final AuthProvider _tokenNotifier;
  AppRouter(this._tokenNotifier);
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: WelcomeRoute.page, path: '/welcome'),
        AutoRoute(page: RegisterRoute.page, path: '/register'),
        AutoRoute(page: LoginWithPasswordRoute.page, path: '/login-with-password'),
        AutoRoute(page: OTPConfirmRoute.page, path: '/otp-confirm'),
        AutoRoute(page: ResetPasswordRoute.page, path: '/reset-password'),
        AutoRoute(page: ForgotPasswordRoute.page, path: '/forgot-password'),
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: HomeRoute.page, guards: [RouteGuard(_tokenNotifier)], path: '/home'),

        /// routes go here
        RedirectRoute(path: '*', redirectTo: '/home'),
      ];
}

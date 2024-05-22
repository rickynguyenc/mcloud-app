import 'package:auto_route/auto_route.dart';
import 'package:mcloud/providers/authentication_provider.dart';
import 'package:mcloud/screens/home_screen.dart';
import '../../screens/authentication/login_screen.dart';
import 'app_route_guard.dart';
part 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final AuthProvider _tokenNotifier;
  AppRouter(this._tokenNotifier);
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: HomeRoute.page, guards: [RouteGuard(_tokenNotifier)], path: '/home'),

        /// routes go here
        RedirectRoute(path: '*', redirectTo: '/home'),
      ];
}

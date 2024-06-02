import 'package:auto_route/auto_route.dart';
import 'package:mcloud/core/utils/local_storage.dart';
import 'package:mcloud/providers/authentication_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_global.dart';
import 'app_route.dart';

class RouteGuard extends AutoRouteGuard {
  RouteGuard(this._tokenNotifier);
  final AuthProvider _tokenNotifier;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_tokenNotifier.isAuthenticated) {
      resolver.next();
    } else {
      final lanTruyCap = UserPreferences.instance.getLanLogin();
      if (lanTruyCap == 0) {
        router.replaceAll([WelcomeRoute()], updateExistingRoutes: true);
      } else {
        router.replaceAll([LoginRoute()], updateExistingRoutes: true);
      }
    }
  }
}

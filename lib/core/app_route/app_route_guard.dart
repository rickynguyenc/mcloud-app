import 'package:auto_route/auto_route.dart';
import 'package:mcloud/providers/authentication_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_global.dart';

class RouteGuard extends AutoRouteGuard {
  RouteGuard(this._tokenNotifier);
  final AuthProvider _tokenNotifier;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // if (_tokenNotifier.isAuthenticated) {
    //   resolver.next();
    // } else {
    //   router.pushAndPopUntil(LoginRoute(), predicate: (e) => false);
    // }
    resolver.next();
  }
}

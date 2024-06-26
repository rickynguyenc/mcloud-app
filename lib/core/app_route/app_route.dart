import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mcloud/generated/l10n.dart';
import 'package:mcloud/models/cart_model.dart';
import 'package:mcloud/providers/authentication_provider.dart';
import 'package:mcloud/screens/account/buy_history_screen.dart';
import 'package:mcloud/screens/account/detail_by_order_screen.dart';
import 'package:mcloud/screens/authentication/change_password_screen.dart';
import 'package:mcloud/screens/cart/check_cart_payment_screen.dart';
import 'package:mcloud/screens/cart/payment_view_screen.dart';
import 'package:mcloud/screens/home_screen.dart';
import '../../screens/account/personal_view_screen.dart';
import '../../screens/authentication/forget_password_screen.dart';
import '../../screens/authentication/login_screen.dart';
import '../../screens/authentication/login_with_password_screen.dart';
import '../../screens/authentication/otp_confirm_screen.dart';
import '../../screens/authentication/register_screen.dart';
import '../../screens/authentication/reset_password_screen.dart';
import '../../screens/authentication/welcome_screen.dart';
import '../../screens/cart/cart_screen.dart';
import '../../screens/product/product_detail_screen.dart';
import '../../screens/product/product_dashboard_screen.dart';
import '../../screens/product/search_product_screen.dart';
import '../../screens/favourite_product/favourite_product_screen.dart';
import '../../screens/notification/notification_dashboard_screen.dart';
import 'app_route_guard.dart';
part 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final AuthProvider _tokenNotifier;
  AppRouter(this._tokenNotifier);
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            page: HomeRoute.page,
            guards: [RouteGuard(_tokenNotifier)],
            path: '/',
            children: [
              AutoRoute(page: ProductDashboardRoute.page, initial: true, path: 'product-dashboard'),
              AutoRoute(page: NotificationProductRoute.page, path: 'notification-product'),
              AutoRoute(page: CartRoute.page, path: 'cart'),
              AutoRoute(page: FavouriteProductRoute.page, path: 'favourite-product'),
              AutoRoute(page: PersonalViewRoute.page, path: 'personal-view'),
            ]),
        AutoRoute(page: WelcomeRoute.page, path: '/welcome'),
        AutoRoute(page: RegisterRoute.page, path: '/register'),
        AutoRoute(page: LoginWithPasswordRoute.page, path: '/login-with-password'),
        AutoRoute(page: OTPConfirmRoute.page, path: '/otp-confirm'),
        AutoRoute(page: ResetPasswordRoute.page, path: '/reset-password'),
        AutoRoute(page: ForgotPasswordRoute.page, path: '/forgot-password'),
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: ProductDetailRoute.page, guards: [RouteGuard(_tokenNotifier)], path: '/product-detail/:productId'),
        AutoRoute(page: PaymentViewRoute.page, guards: [RouteGuard(_tokenNotifier)], path: '/payment-view/:linkOnePay'),
        AutoRoute(page: CheckCartPaymentRoute.page, guards: [RouteGuard(_tokenNotifier)], path: '/check-cart-payment'),
        AutoRoute(page: SearchProductRoute.page, guards: [RouteGuard(_tokenNotifier)], path: '/search-product'),
        AutoRoute(page: BuyHistoryRoute.page, guards: [RouteGuard(_tokenNotifier)], path: '/buy-history'),
        AutoRoute(page: DetailOrderRoute.page, guards: [RouteGuard(_tokenNotifier)], path: '/detail-order'),

        /// routes go here
        RedirectRoute(path: '*', redirectTo: '/'),
      ];
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mcloud/core/app_route/app_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcloud/core/utils/local_storage.dart';
import 'package:mcloud/providers/user_infor_provider.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      final idUser = UserPreferences.instance.getUserId();
      ref.read(userInforProvider.notifier).getUserInfor(idUser ?? 0);
      return null;
    }, []);
    return AutoTabsScaffold(
      routes: [
        ProductDashboardRoute(),
        NotificationProductRoute(),
        CartRoute(isShowBack: false),
        FavouriteProductRoute(),
        PersonalViewRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xff055FA7),
          unselectedItemColor: Color(0xff2B2B2B),
          selectedLabelStyle: TextStyle(
            color: Color(0xff055FA7),
          ),
          unselectedLabelStyle: TextStyle(
            color: Color(0xff2B2B2B),
          ),
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Trang chủ'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_none_outlined), label: 'Thông báo'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Giỏ hàng'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_outline_outlined), label: 'Yêu thích'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: 'Tài khoản'),
          ],
        );
      },
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcloud/core/app_route/app_route.dart';
import 'package:mcloud/core/utils/env.dart';
import 'package:mcloud/providers/authentication_provider.dart';
import 'package:mcloud/providers/quote_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/utils/local_storage.dart';
import 'core/utils/theme/mcloud_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: Environment.fileName);
  await UserPreferences.initialize();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  MyApp({Key? key}) : super(key: key);
  late AppRouter router;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      router = AppRouter(ref.read(authProvider));
      return null;
    }, []);
    return MaterialApp.router(
      locale: const Locale('vi', 'VN'),
      routeInformationParser: router.defaultRouteParser(),
      routerDelegate: AutoRouterDelegate(
        router,
        initialRoutes: [const HomeRoute()],
        navigatorObservers: () => [AutoRouteObserver()],
      ),
      debugShowCheckedModeBanner: false,
      theme: MCloudTheme.lightTheme,
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light,
    );
  }
}

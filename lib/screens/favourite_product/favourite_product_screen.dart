import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mcloud/core/app_route/app_route.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class FavouriteProductScreen extends HookConsumerWidget {
  const FavouriteProductScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sản phẩm yêu thích'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.router.replace(LoginRoute());
            },
          )
        ],
      ),
      body: Container(child: Text('Sản phẩm yêu thích screen')),
    );
  }
}

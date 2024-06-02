import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcloud/core/app_route/app_route.dart';

import '../../providers/authentication_provider.dart';

@RoutePage()
class PersonalViewScreen extends HookConsumerWidget {
  const PersonalViewScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF5F5F5),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 48),
            Container(
              height: 56,
              alignment: Alignment.center,
              child: Text(
                'Quản lý tài khoản',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Center(
                  child: TextButton(
                onPressed: () {
                  ref.read(authProvider).logout();
                  AutoRouter.of(context).pushAndPopUntil(const LoginRoute(), predicate: (_) => true);
                },
                child: Text(
                  'Đăng xuất',
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

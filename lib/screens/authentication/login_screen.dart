import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcloud/core/app_route/app_route.dart';

import '../../core/utils/widgets/submit_button_widget.dart';
import '../../providers/authentication_provider.dart';

@RoutePage()
class LoginScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 64,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 16),
              child: Image.asset('assets/images/banner_login.png', height: 164),
            ),
            SizedBox(
              height: 32,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'Chào mừng đã trở lại!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF212121),
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFEEEEEE)),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/images/google.png',
                        height: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Tiếp tục với Google',
                      style: TextStyle(
                        color: Color(0xFF212121),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.20,
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 16,
            ),
            Container(
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFEEEEEE)),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/images/facebook.png',
                        height: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Tiếp tục với Facebook',
                      style: TextStyle(
                        color: Color(0xFF212121),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.20,
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 16,
            ),
            Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFEEEEEE)),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/apple.png',
                      height: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Tiếp tục với Apple',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    color: Color(0xFFBDBDBD),
                    height: 1,
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  'or',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF616161),
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    color: Color(0xFFBDBDBD),
                    height: 1,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 28,
            ),
            Container(
                width: double.infinity,
                height: 48,
                decoration: ShapeDecoration(
                  color: Color(0xFF055FA7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(56),
                  ),
                ),
                child: SubmitButton(
                  'Đăng nhập bằng mật khẩu',
                  onPressed: () {
                    context.router.push(LoginWithPasswordRoute());
                  },
                )),
            Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Bạn chưa có tài khoản?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.20,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size(0, 24)),
                  onPressed: () {
                    context.router.push(RegisterRoute());
                  },
                  child: Text(
                    ' Đăng ký',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF055FA7),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.20,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48,
            ),
          ],
        ),
      ),
    );
  }
}

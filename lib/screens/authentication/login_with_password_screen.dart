import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/app_route/app_route.dart';
import '../../core/utils/widgets/submit_button_widget.dart';
import '../../core/utils/widgets/text_field_widget.dart';
import '../../providers/authentication_provider.dart';

@RoutePage()
class LoginWithPasswordScreen extends HookConsumerWidget {
  final _userNameFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _txtUsernameCtrl = TextEditingController();
  final _txtPasswordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _rememberLogin = useState(false);
    final _username = useState('');
    final _password = useState('');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32),
            Row(
              children: [
                Container(
                    width: 24,
                    height: 24,
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_outlined,
                          size: 24,
                        ),
                        onPressed: () => context.router.pop())),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 16),
                    child: Image.asset('assets/images/logo.png', height: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Chào mừng bạn trở lại',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF212121),
                        fontSize: 24,
                        height: 1.7,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 283,
                      child: Text(
                        'Đăng nhập để trải nghiệm trọn vẹn với eStore',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF616161),
                          fontSize: 16,
                          height: 1.7,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Tên đăng nhập',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFieldWidget(
                    formKey: _userNameFormKey,
                    hintText: 'Enter your username',
                    onChanged: (value) => _username.value = value,
                    validateFunc: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    controller: _txtUsernameCtrl,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Mật khẩu',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFieldWidget(
                    formKey: _passwordFormKey,
                    hintText: 'Enter your password',
                    onChanged: (value) => _password.value = value,
                    validateFunc: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    controller: _txtPasswordCtrl,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: _rememberLogin.value,
                                onChanged: (value) {
                                  _rememberLogin.value = value ?? false;
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                side: BorderSide(
                                  color: Color(0xFF055FA7),
                                  width: 1,
                                ),
                                activeColor: Color(0xFF055FA7),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Ghi nhớ tôi',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Quên mật khẩu',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFF055FA7),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Container(
                    height: 48,
                    width: double.infinity,
                    child: SubmitButton(
                      'Tiếp tục',
                      onPressed: () {
                        if (_passwordFormKey.currentState!.validate() && _userNameFormKey.currentState!.validate()) {
                          ref.read(authProvider).login().then((value) {
                            if (value) {
                              context.router.push(HomeRoute());
                            }
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 24),
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
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: 88,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Color(0xFFEEEEEE)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.blue,
                              backgroundColor: Colors.white,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              fixedSize: Size(88, 60),
                              padding: EdgeInsets.zero),
                          onPressed: () {},
                          child: Image.asset(
                            'assets/images/facebook.png',
                            height: 24,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 60,
                        width: 88,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Color(0xFFEEEEEE)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.blue,
                              backgroundColor: Colors.white,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              fixedSize: Size(88, 60),
                              padding: EdgeInsets.zero),
                          onPressed: () {},
                          child: Image.asset(
                            'assets/images/google.png',
                            height: 24,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 60,
                        width: 88,
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1, color: Color(0xFFEEEEEE)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.blue,
                              backgroundColor: Colors.white,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              fixedSize: Size(88, 60),
                              padding: EdgeInsets.zero),
                          onPressed: () {},
                          child: Image.asset(
                            'assets/images/apple.png',
                            height: 24,
                          ),
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.max,
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
          ],
        ),
      ),
    );
  }
}

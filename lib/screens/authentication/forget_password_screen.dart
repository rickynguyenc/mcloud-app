import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcloud/core/app_route/app_route.dart';
import 'package:mcloud/core/utils/extension/common_function.dart';
import 'package:mcloud/core/utils/widgets/loading_mark.dart';
import 'package:mcloud/core/utils/widgets/submit_button_widget.dart';
import 'package:mcloud/core/utils/widgets/text_field_widget.dart';
import 'package:mcloud/providers/authentication_provider.dart';

@RoutePage()
class ForgotPasswordScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _emailFormKey = GlobalKey<FormState>();
    final _txtEmailCtrl = TextEditingController();
    final isLoading = useState(false);
    return Stack(children: [
      Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 24,
                      ),
                      onPressed: () {
                        context.router.pop();
                      },
                    ),
                  )
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
                        'Đặt lại mật khẩu',
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
                          'Nhập Email của bạn. Một mã OTP sẽ được gửi để đặt lại mật khẩu mới.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF616161),
                            fontSize: 16,
                            height: 1.7,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFieldWidget(
                      formKey: _emailFormKey,
                      hintText: 'Enter your email',
                      onChanged: (value) {},
                      validateFunc: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      controller: _txtEmailCtrl,
                    ),
                    Spacer(),
                    Container(
                      height: 48,
                      width: double.infinity,
                      child: SubmitButton(
                        'Tiếp tục',
                        onPressed: () async {
                          if (_emailFormKey.currentState!.validate()) {
                            isLoading.value = true;
                            final result = await ref.read(authProvider).forgotPassword(_txtEmailCtrl.text);
                            isLoading.value = false;
                            if (result) {
                              context.router.push(ResetPasswordRoute(email: _txtEmailCtrl.text));
                            } else {
                              CommonFunction.showSnackBar('Email của bạn không đúng', context, Colors.red);
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      isLoading.value ? Loading() : const SizedBox.shrink(),
    ]);
  }
}

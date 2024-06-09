import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcloud/core/app_route/app_route.dart';
import 'package:mcloud/core/utils/env.dart';
import 'package:mcloud/providers/user_infor_provider.dart';

import '../../providers/authentication_provider.dart';

@RoutePage()
class PersonalViewScreen extends HookConsumerWidget {
  const PersonalViewScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfor = ref.watch(userInforProvider);
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              '${Environment.apiUrl}/${userInfor.avatarUrl}',
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/images/banner_login.png');
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 14),
                        Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userInfor.name ?? '',
                                style: TextStyle(
                                  color: Color(0xFF212121),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                userInfor.partnerId?.mobile?.toString() ?? '',
                                style: TextStyle(
                                  color: Color(0xFF9CA3AF),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Container(
                          // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          width: 100,
                          height: 44,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(color: Color(0xffE6EFF6), borderRadius: BorderRadius.circular(8)),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 24.50,
                                top: 14,
                                child: Text(
                                  '730',
                                  style: TextStyle(
                                    color: Color(0xFF055FA7),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 59.50,
                                top: 0,
                                child: Container(
                                  width: 37,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/score_star.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Container(
                      height: 76,
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.98, -0.20),
                          end: Alignment(-1.8, 0.2),
                          colors: [Color(0xFF055FA7), Color(0xFFD1146E), Color(0xFFD83B35)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                        SizedBox(width: 24),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Số dư tài khoản',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '150.000  VNĐ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.30,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: IconButton(
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all<Size>(Size(36, 36)),
                                  minimumSize: MaterialStateProperty.all<Size>(Size(36, 36)),
                                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  'assets/icons/wallet-add.svg',
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Nạp tiền',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 18),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: IconButton(
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all<Size>(Size(36, 36)),
                                  minimumSize: MaterialStateProperty.all<Size>(Size(36, 36)),
                                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  'assets/icons/u_history.svg',
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Giao dịch',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 24),
                      ]),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'TÀI KHOẢN',
                      style: TextStyle(
                        color: Color(0xFFBDBDBD),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 32),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: Color(0xFFE6F4FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset('assets/icons/profile_notoutline.svg', width: 24, height: 24),
                        ),
                        SizedBox(width: 16),
                        Text(
                          'Thông tin tài khoản',
                          style: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 24,
                          height: 24,
                          child: IconButton(
                            onPressed: () {
                              // context.router.push(ProfileEditRoute());
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        )
                      ],
                    ),
                    SizedBox(height: 32),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: Color(0xFFE6F4FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset('assets/icons/shopping-cart.svg', width: 24, height: 24),
                        ),
                        SizedBox(width: 16),
                        Text(
                          'Lịch sử mua hàng',
                          style: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 24,
                          height: 24,
                          child: IconButton(
                            onPressed: () {
                              context.router.push(BuyHistoryRoute(isShowBack: true));
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        )
                      ],
                    ),
                    SizedBox(height: 32),
                    Text(
                      'TRUNG TÂM TRỢ GIÚP',
                      style: TextStyle(
                        color: Color(0xFFBDBDBD),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 32),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: ShapeDecoration(
                            color: Color(0xFFE6F4FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset('assets/icons/like.svg', width: 24, height: 24),
                        ),
                        SizedBox(width: 16),
                        InkWell(
                          onTap: () {
                            ref.read(authProvider).logout();
                            context.router.replaceAll([LoginRoute()], updateExistingRoutes: true);
                          },
                          child: Text(
                            'Đăng xuất',
                            style: TextStyle(
                              color: Color(0xFF212121),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 24,
                          height: 24,
                          child: IconButton(
                            onPressed: () {
                              ref.read(authProvider).logout();
                              context.router.replaceAll([LoginRoute()], updateExistingRoutes: true);
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        )
                      ],
                    ),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

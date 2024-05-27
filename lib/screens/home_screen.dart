import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcloud/core/app_route/app_route.dart';
import 'package:mcloud/models/quote_model.dart';
import 'package:mcloud/providers/quote_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/utils/widgets/search_widget.dart';
import '../core/utils/widgets/sliderbar_widget.dart';
import '../providers/authentication_provider.dart';
import '../services/quote_service.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  final _scrollCtrl = ScrollController();
  void _refresh(WidgetRef ref) {
    ref.refresh(quoteProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 48),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset('assets/images/banner_login.png'),
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
                        'Tuấn Nguyễn',
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Welcome ',
                              style: TextStyle(
                                color: Color(0xFF055FA7),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.32,
                              ),
                            ),
                            TextSpan(
                              text: '👋',
                              style: TextStyle(
                                color: Color(0xFF055FA7),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.32,
                              ),
                            ),
                          ],
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
                            fontFamily: 'Inter',
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
            SearchBarWidget(
              textSearch: '',
              hintText: 'Search...',
              onChanged: (value) {},
              onSubmit: (value) {},
            ),
            SizedBox(height: 24),
            SliderBarWidget(
              aspectRatio: 1.5,
              imgList: [
                BannerImage(image: 'assets/images/banner_home.png'),
                BannerImage(image: 'assets/images/banner_home.png'),
                BannerImage(image: 'assets/images/banner_home.png'),
              ],
            ),
            Expanded(
              child: Scrollbar(
                controller: _scrollCtrl,
                child: SingleChildScrollView(
                  controller: _scrollCtrl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CategoryItemWidget(
                              'Phần Mềm',
                              'assets/images/category_1.png',
                            ),
                          ),
                          SizedBox(width: 22),
                          Expanded(
                            child: CategoryItemWidget(
                              'Lưu trữ',
                              'assets/images/category_2.png',
                            ),
                          ),
                          SizedBox(width: 22),
                          Expanded(
                            child: CategoryItemWidget(
                              'Gói cước',
                              'assets/images/category_3.png',
                            ),
                          ),
                          SizedBox(width: 22),
                          Expanded(
                            child: CategoryItemWidget(
                              'Đối tác',
                              'assets/images/category_4.png',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Ưu đãi hot',
                            style: TextStyle(
                              color: Color(0xFF212121),
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Xem thêm',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF055FA7),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.20,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      SliderBarWidget(aspectRatio: 2.08, width: MediaQuery.of(context).size.width * 0.7, imgList: [
                        BannerImage(image: 'assets/images/voucher_1.png'),
                        BannerImage(image: 'assets/images/voucher_1.png'),
                        BannerImage(image: 'assets/images/voucher_1.png'),
                        BannerImage(image: 'assets/images/voucher_1.png'),
                      ]),
                      SizedBox(height: 35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Sản phẩm mới',
                            style: TextStyle(
                              color: Color(0xFF212121),
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Xem thêm',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFF055FA7),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItemWidget extends HookConsumerWidget {
  final String title;
  final String iamgeLink;
  const CategoryItemWidget(this.title, this.iamgeLink, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: Image.asset(iamgeLink).image,
          fit: BoxFit.fitWidth,
        ),
        SizedBox(height: 8),
        Text(
          'Phần Mềm ',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

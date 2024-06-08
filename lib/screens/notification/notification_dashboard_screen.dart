import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class NotificationProductScreen extends HookConsumerWidget {
  const NotificationProductScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 48),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      decoration: ShapeDecoration(
                        color: Color(0xFFF5F5F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                      ),
                      child: Text(
                        'Thông báo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 44,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8),
                      decoration: ShapeDecoration(
                        color: Color(0xFF055FA7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                      ),
                      child: Text(
                        'Tin nhắn',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFFAFAFA),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 36),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Recent Notification',
                          style: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 22,
                          height: 22,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 22,
                                  height: 22,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF055FA7),
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 7.70,
                                top: 2.20,
                                child: SizedBox(
                                  width: 6.60,
                                  height: 17.60,
                                  child: Text(
                                    '2\n',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xFFF4F4F4),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Clear All',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Color(0xFF055FA7),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    NotificationElementWidget(),
                    NotificationElementWidget(),
                    NotificationElementWidget(),
                    NotificationElementWidget(),
                    NotificationElementWidget(),
                    NotificationElementWidget(),
                    NotificationElementWidget(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Notification Element
class NotificationElementWidget extends HookConsumerWidget {
  const NotificationElementWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: Color(0xFFF5F5F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/banner_login.png'),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'We have bookmarked a property “Casa De Leone” for you. Find out more about the property!',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '2 hours Ago',
                    style: TextStyle(
                      color: Color(0xFFB8B8B8),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.06,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mcloud/core/app_route/app_route.dart';
import 'package:mcloud/core/utils/env.dart';

import '../../../models/home_model.dart';

class ProductItemInGridWidget extends HookConsumerWidget {
  final Product productElement;
  const ProductItemInGridWidget(this.productElement, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: () {
            AutoRouter.of(context).push(ProductDetailRoute(productId: int.parse(productElement.id.toString())));
          },
          child: Container(
            // height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.89),
              boxShadow: [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 6.80,
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                )
              ],
              // color: Colors.blueGrey,
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    '${Environment.apiUrl}/${productElement.avatarUrl ?? ''}',
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Image(
                        image: AssetImage('assets/images/banner_home.png'),
                      );
                    },
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productElement.name ?? '',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 10.09,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.25,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 48.41,
                            padding: const EdgeInsets.symmetric(horizontal: 4.20),
                            decoration: BoxDecoration(color: Color(0xFFFCAC12)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Giảm 30%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8.41,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: -0.21,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Container(
                            height: 12.61,
                            padding: const EdgeInsets.symmetric(horizontal: 4.20),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 0.84, color: Color(0xFFFD3C4A)),
                              ),
                            ),
                            child: Text(
                              'Mua kèm Deal sốc',
                              style: TextStyle(
                                color: Color(0xFFFD3C4A),
                                fontSize: 8.41,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.21,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '450.000',
                              style: TextStyle(
                                color: Color(0xFF90909F),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.lineThrough,
                                letterSpacing: -0.35,
                              ),
                            ),
                            TextSpan(
                              text: 'đ  ',
                              style: TextStyle(
                                color: Color(0xFF90909F),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.35,
                              ),
                            ),
                            TextSpan(
                              text: '${NumberFormat('#,###', 'en_US').format(productElement.listPrice)}đ',
                              style: TextStyle(
                                color: Color(0xFF055FA7),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          )),
    );
  }
}

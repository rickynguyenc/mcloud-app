import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mcloud/core/app_route/app_route.dart';
import 'package:mcloud/core/utils/env.dart';
import 'package:mcloud/core/utils/widgets/shimmer_loading/common_simmer.dart';
import 'package:mcloud/models/order_model.dart';
import 'package:mcloud/providers/order_provider.dart';

@RoutePage()
class BuyHistoryScreen extends HookConsumerWidget {
  final bool isShowBack;
  BuyHistoryScreen(this.isShowBack, {super.key});
  int countMoney = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollCtrlMain = useScrollController();
    final isLoading = useState(true);
    final orderAllData = ref.watch(orderProvider.notifier).lstOrderItem;
    final tabNow = useState(0);
    final lstStatus = ['wait', 'paid', 'cancel error'];
    useEffect(() {
      ref.read(orderProvider).getOrder().then((value) {
        isLoading.value = false;
      });
      return null;
    }, const []);
    return isLoading.value
        ? Padding(padding: EdgeInsets.only(top: 48), child: CommonSimmer())
        : Stack(
            children: [
              Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 48),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          if (isShowBack)
                            IconButton(
                              onPressed: () {
                                AutoRouter.of(context).pop();
                              },
                              icon: Icon(Icons.arrow_back_ios),
                            ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Lịch sử đơn hàng',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          // Cart button
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              'assets/icons/search-normal.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                height: 45,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: tabNow.value == 0 ? Color(0xFF055FA7) : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.white,
                                    shadowColor: Colors.transparent,
                                    minimumSize: Size(40, 21),
                                  ),
                                  onPressed: () {
                                    countMoney = 0;
                                    orderAllData.forEach((element) {
                                      if (lstStatus[0].contains(element?.status ?? '')) {
                                        countMoney += ((element?.amountTotal ?? 0).round());
                                      }
                                    });
                                    tabNow.value = 0;
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'Chưa Thanh Toán',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: tabNow.value == 0 ? Color(0xFF055FA7) : Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(color: tabNow.value == 0 ? Color(0xffffab00) : Color(0xffFFD700).withOpacity(0.16), borderRadius: BorderRadius.circular(6)),
                                        alignment: Alignment.center,
                                        child: Text(
                                          orderAllData.where((element) => lstStatus[0].contains(element?.status ?? '')).length.toString(),
                                          style: TextStyle(color: tabNow.value == 0 ? Colors.black : Color(0xffB76E00), fontSize: 14, fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 45,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: tabNow.value == 1 ? Color(0xFF055FA7) : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.white,
                                    shadowColor: Colors.transparent,
                                    minimumSize: Size(40, 21),
                                  ),
                                  onPressed: () {
                                    countMoney = 0;
                                    orderAllData.forEach((element) {
                                      if (lstStatus[1].contains(element?.status ?? '')) {
                                        countMoney += ((element?.amountTotal ?? 0).round());
                                      }
                                    });
                                    tabNow.value = 1;
                                  },
                                  child: Row(children: [
                                    Text(
                                      'Đã Hoàn Thành',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: tabNow.value == 1 ? Color(0xFF055FA7) : Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(color: tabNow.value == 1 ? Colors.green : Color(0xff22c55e).withOpacity(0.16), borderRadius: BorderRadius.circular(6)),
                                      alignment: Alignment.center,
                                      child: Text(
                                        orderAllData.where((element) => lstStatus[1].contains(element?.status ?? '')).length.toString(),
                                        style: TextStyle(color: tabNow.value == 1 ? Colors.white : Color(0xff118d57), fontSize: 14, fontWeight: FontWeight.w700),
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                              Container(
                                height: 45,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: tabNow.value == 2 ? Color(0xFF055FA7) : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.white,
                                    shadowColor: Colors.transparent,
                                    minimumSize: Size(40, 21),
                                  ),
                                  onPressed: () {
                                    countMoney = 0;
                                    orderAllData.forEach((element) {
                                      if (lstStatus[2].contains(element?.status ?? '')) {
                                        countMoney += ((element?.amountTotal ?? 0).round());
                                      }
                                    });
                                    tabNow.value = 2;
                                  },
                                  child: Row(children: [
                                    Text(
                                      'Đã Hủy',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: tabNow.value == 2 ? Color(0xFF055FA7) : Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(color: tabNow.value == 2 ? Colors.red : Color(0xffFF5630).withOpacity(0.16), borderRadius: BorderRadius.circular(6)),
                                      alignment: Alignment.center,
                                      child: Text(
                                        orderAllData.where((element) => lstStatus[2].contains(element?.status ?? '')).length.toString(),
                                        style: TextStyle(color: tabNow.value == 2 ? Colors.white : Color(0xffB71D18), fontSize: 14, fontWeight: FontWeight.w700),
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                      child: orderAllData.isEmpty
                          ? Container(
                              alignment: Alignment.center,
                              child: Text('Không có dữ liệu'),
                            )
                          : Scrollbar(
                              controller: scrollCtrlMain,
                              child:
                                  // SingleChildScrollView(
                                  //   controller: scrollCtrlMain,
                                  //   child: Column(
                                  //     children: orderAllData.map((e)=> lstStatus).map((e) => ProductInBuyHistoryElemnt(e??OrderItem(),)).toList(),
                                  //   ),
                                  // ),
                                  ListView.builder(
                                controller: scrollCtrlMain,
                                itemBuilder: (ctx, index) {
                                  return lstStatus[tabNow.value].contains(orderAllData[index]?.status ?? '')
                                      ? ProductInBuyHistoryElemnt(
                                          orderAllData[index] ?? OrderItem(),
                                          tabNow.value,
                                        )
                                      : SizedBox.shrink();
                                },
                                itemCount: orderAllData.length,
                                shrinkWrap: true,
                                // physics: NeverScrollableScrollPhysics(),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 64,
                    )
                  ],
                ),
                bottomSheet: Container(
                  height: 64,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x0F000000),
                        blurRadius: 16,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Tổng cộng:',
                            style: TextStyle(
                              color: Color(0xFF717171),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${NumberFormat('#,###', 'en_US').format(countMoney)} vnđ',
                            style: TextStyle(
                              color: Color(0xFF055FA7),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      // Container(
                      //     alignment: Alignment.center,
                      //     height: 48,
                      //     clipBehavior: Clip.antiAlias,
                      //     decoration: ShapeDecoration(
                      //       color: Color(0xFFD83B35),
                      //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                      //     ),
                      //     child: tabNow.value == 0
                      //         ? ElevatedButton(
                      //             onPressed: () {
                      //               // context.router.push(CheckCartPaymentRoute(lstOrderLineChoosed: ));
                      //             },
                      //             child: Text('Thanh toán ngay'),
                      //             style: ElevatedButton.styleFrom(
                      //               backgroundColor: Color(0xFFD83B35),
                      //               shadowColor: Colors.transparent,
                      //               shape: RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.circular(9),
                      //               ),
                      //               fixedSize: Size(double.nan, 48),
                      //             ),
                      //           )
                      //         : ElevatedButton(
                      //             onPressed: () {},
                      //             child: Text('Mua lại', style: TextStyle(color: Colors.red)),
                      //             style: ElevatedButton.styleFrom(
                      //               backgroundColor: Colors.white,
                      //               shadowColor: Colors.transparent,
                      //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9), side: BorderSide(color: Colors.red, width: 1)),
                      //               fixedSize: Size(double.nan, 48),
                      //             ),
                      //           )),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}

class ProductInBuyHistoryElemnt extends HookConsumerWidget {
  final OrderItem orderItem;
  final int tabCurent;
  const ProductInBuyHistoryElemnt(this.orderItem, this.tabCurent, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        AutoRouter.of(context).push(DetailOrderRoute(orderId: int.parse(orderItem.id.toString())));
      },
      child: Material(
        child: Container(
          padding: EdgeInsets.only(left: 24, bottom: 16, top: 16, right: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage('assets/images/banner_login.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderItem.orderLine?[0].productId?.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 6),
                    Row(children: [
                      Text(
                        'Bảo hành 12 tháng',
                        style: TextStyle(
                          color: Color(0xFF616161),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: tabCurent == 0
                              ? Color(0xffFFD700).withOpacity(0.16)
                              : tabCurent == 1
                                  ? Colors.green.shade200
                                  : Colors.red.shade200,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          tabCurent == 0
                              ? 'Chờ thanh toán'
                              : tabCurent == 1
                                  ? 'Đã thanh toán'
                                  : 'Đã hủy',
                          style: TextStyle(
                              color: tabCurent == 0
                                  ? Color(0xffB76E00)
                                  : tabCurent == 1
                                      ? Colors.green
                                      : Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ]),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          '${orderItem.orderLine?[0].priceUnit?.round()} đ',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          'Số lượng: ${orderItem.orderLine?[0].productUomQty?.round() ?? 0}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

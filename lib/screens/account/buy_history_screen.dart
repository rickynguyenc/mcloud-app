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
    final lstStatus = ['wait error', 'paid', 'cancel'];
    useEffect(() {
      ref.read(orderProvider).getOrder().then((value) {
        isLoading.value = false;
      });
      return null;
    }, const []);
    return isLoading.value
        ? Padding(padding: EdgeInsets.only(top: 48), child: CommonSimmer())
        : Stack(children: [
            Scaffold(
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
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                height: 45,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 21),
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
                                  child: Text(
                                    'Chưa Thanh Toán',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: tabNow.value == 0 ? Color(0xFF055FA7) : Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 45,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 21),
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
                                  child: Text(
                                    'Đã Hoàn Thành',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: tabNow.value == 1 ? Color(0xFF055FA7) : Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 45,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 21),
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
                                  child: Text(
                                    'Đã Hủy',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: tabNow.value == 2 ? Color(0xFF055FA7) : Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
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
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Scrollbar(
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
                                          )
                                        : SizedBox.shrink();
                                  },
                                  itemCount: orderAllData.length,
                                  shrinkWrap: true,
                                  // physics: NeverScrollableScrollPhysics(),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
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
                          '${NumberFormat('#,###', 'en_US').format(countMoney)}đ',
                          style: TextStyle(
                            color: Color(0xFF055FA7),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                        alignment: Alignment.center,
                        height: 48,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Color(0xFFD83B35),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                        ),
                        child: tabNow.value == 0
                            ? ElevatedButton(
                                onPressed: () {
                                  // context.router.push(CheckCartPaymentRoute(lstOrderLineChoosed: ));
                                },
                                child: Text('Thanh toán ngay'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFD83B35),
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  fixedSize: Size(double.nan, 48),
                                ),
                              )
                            : ElevatedButton(
                                onPressed: () {},
                                child: Text('Mua lại', style: TextStyle(color: Colors.red)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9), side: BorderSide(color: Colors.red, width: 1)),
                                  fixedSize: Size(double.nan, 48),
                                ),
                              )),
                  ],
                ),
              ),
            )
          ]);
  }
}

class ProductInBuyHistoryElemnt extends HookConsumerWidget {
  final OrderItem orderItem;
  const ProductInBuyHistoryElemnt(this.orderItem, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
                Text(
                  'Bảo hành 12 tháng',
                  style: TextStyle(
                    color: Color(0xFF616161),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mcloud/core/app_route/app_route.dart';
import 'package:mcloud/core/utils/env.dart';
import 'package:mcloud/core/utils/widgets/loading_mark.dart';
import 'package:mcloud/models/cart_model.dart';
import 'package:mcloud/providers/cart_provider.dart';

import '../../core/utils/widgets/shimmer_loading/common_simmer.dart';

@RoutePage()
class CartScreen extends HookConsumerWidget {
  final lstOrderLineChoosed = <OrderLine>[];
  CartScreen();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countMoney = useState(0);
    final scrollCtrlMain = useScrollController();
    final cartLstProduct = ref.watch(cartProvider);
    final cartNotifier = ref.watch(cartProvider.notifier);
    final isLoading = useState(true);
    final isRequesting = useState(false);
    final isChoosedAll = useState(false);
    useEffect(() {
      ref.read(cartProvider.notifier).getCart().then((value) => isLoading.value = false);
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
                                'Giỏ hàng của tôi',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          // Cart button
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              'assets/icons/horizontal-container.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      if (cartLstProduct.isNotEmpty)
                        Expanded(
                          child: Scrollbar(
                            controller: scrollCtrlMain,
                            child: ListView.builder(
                              controller: scrollCtrlMain,
                              itemBuilder: (ctx, index) {
                                return ProductInCartElemnt(
                                  cartLstProduct[0].orderLine![index],
                                  (orderLine) {
                                    if (orderLine.productUomQty == 0) {
                                      return;
                                    }
                                    isRequesting.value = true;
                                    cartNotifier.updateCart(orderLine.id ?? 0, (orderLine.productUomQty ?? 0) - 1).then((value) {
                                      isRequesting.value = false;
                                    });
                                  },
                                  (orderLine) {
                                    isRequesting.value = true;
                                    cartNotifier.updateCart(orderLine.id ?? 0, (orderLine.productUomQty ?? 0) + 1).then((value) {
                                      isRequesting.value = false;
                                    });
                                  },
                                  (orderLine) {
                                    if (orderLine.productUomQty == 0) {
                                      return;
                                    }
                                    if (orderLine.isChoose == true) {
                                      if (!lstOrderLineChoosed.contains(orderLine)) {
                                        lstOrderLineChoosed.add(orderLine);
                                        countMoney.value += orderLine.priceUnit?.round() ?? 0;
                                      }
                                    } else {
                                      if (lstOrderLineChoosed.contains(orderLine)) {
                                        lstOrderLineChoosed.remove(orderLine);
                                        countMoney.value -= orderLine.priceUnit?.round() ?? 0;
                                      }
                                    }
                                  },
                                );
                              },
                              itemCount: cartLstProduct[0].orderLine?.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            ),
                          ),
                        ),
                    ],
                  )),
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
                    Checkbox(
                      value: isChoosedAll.value,
                      onChanged: (value) {
                        isChoosedAll.value = !isChoosedAll.value;
                        lstOrderLineChoosed.clear();
                        countMoney.value = 0;
                        cartLstProduct[0].orderLine?.forEach((element) {
                          element.isChoose = isChoosedAll.value;
                          if (isChoosedAll.value) {
                            lstOrderLineChoosed.add(element);
                            countMoney.value += element.priceUnit?.round() ?? 0;
                          }
                        });
                      },
                      activeColor: Color(0xffFF6C44),
                    ),
                    Text(
                      'Tất cả',
                      style: TextStyle(
                        color: Color(0xFF717171),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
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
                        SizedBox(height: 8),
                        Text(
                          '${NumberFormat('#,###', 'en_US').format(countMoney.value)}đ',
                          style: TextStyle(
                            color: Color(0xFF055FA7),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16),
                    Container(
                      alignment: Alignment.center,
                      height: 48,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Color(0xFFD83B35),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          context.router.push(CheckCartPaymentRoute(lstOrderLineChoosed: lstOrderLineChoosed));
                        },
                        child: Text('Thanh toán'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFD83B35),
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          fixedSize: Size(double.nan, 48),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isRequesting.value ? Loading() : SizedBox.shrink(),
          ]);
  }
}

// cart Element
class ProductInCartElemnt extends HookConsumerWidget {
  final OrderLine orderLine;
  final Function(OrderLine) onRemove;
  final Function(OrderLine) onAdd;
  final Function(OrderLine) onChoose;
  const ProductInCartElemnt(this.orderLine, this.onRemove, this.onAdd, this.onChoose, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Checkbox(
            value: orderLine.isChoose ?? false,
            onChanged: (value) {
              orderLine.isChoose = !orderLine.isChoose!;
              onChoose(orderLine);
            },
            activeColor: Color(0xffFF6C44),
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage('${Environment.apiUrl}${orderLine.productId?.avatarUrl ?? ''}'),
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
                  orderLine.productId?.name ?? '',
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
                      '${orderLine.priceUnit} đ',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Container(
                      child: IconButton(
                        onPressed: () {
                          onRemove(orderLine);
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          fixedSize: MaterialStateProperty.all(Size(24, 24)),
                        ),
                        icon: Icon(Icons.remove),
                      ),
                    ),
                    Text(
                      orderLine.productUomQty.toString(),
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      child: IconButton(
                        onPressed: () {
                          onAdd(orderLine);
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          fixedSize: MaterialStateProperty.all(Size(24, 24)),
                        ),
                        icon: Icon(Icons.add),
                      ),
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

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
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
  final bool isShowBack;
  final lstOrderLineChoosed = <OrderLine>[];
  late SwipeActionController _swipecontroller;
  CartScreen(this.isShowBack);
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
      _swipecontroller = SwipeActionController(selectedIndexPathsChangeCallback: (changedIndexPaths, selected, currentCount) {});
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
                                    cartNotifier.updateCart(orderLine.productId?.id ?? 0, (orderLine.productUomQty ?? 0) - 1).then((value) {
                                      isRequesting.value = false;
                                    });
                                  },
                                  _swipecontroller,
                                  (orderLine) {
                                    isRequesting.value = true;
                                    cartNotifier.updateCart(orderLine.productId?.id ?? 0, (orderLine.productUomQty ?? 0) + 1).then((value) {
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
                                  (orderLine) {
                                    isRequesting.value = true;
                                    cartNotifier.updateCart(orderLine.productId?.id ?? 0, (orderLine.productUomQty ?? 0) - 1).then((value) {
                                      isRequesting.value = false;
                                    });
                                  },
                                );
                              },
                              itemCount: cartLstProduct[0].orderLine?.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            ),
                          ),
                        ),
                      SizedBox(height: 64),
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
  final Function(OrderLine) onDelete;
  final SwipeActionController? controller;
  const ProductInCartElemnt(this.orderLine, this.onRemove, this.controller, this.onAdd, this.onChoose, this.onDelete, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isShowDelete = useState(false);
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: SwipeActionCell(
        controller: controller,
        // Required!
        key: ValueKey(orderLine),

        // Animation default value below
        // deleteAnimationDuration: 400,
        selectedForegroundColor: Colors.black.withAlpha(30),
        trailingActions: [
          SwipeAction(
              icon: Icon(
                Icons.delete_outline_rounded,
                size: 24,
                color: Colors.white,
              ),
              performsFirstActionWithFullSwipe: false,
              color: Color(0xFF055FA7),
              closeOnTap: true,
              nestedAction: SwipeNestedAction(title: "Xóa "),
              onTap: (handler) async {
                onDelete(orderLine);
                // await handler(true);
              }),
        ],
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
                        '${NumberFormat('#,###', 'en_US').format(orderLine.priceUnit)} đ',
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
                        orderLine.productUomQty?.round().toString() ?? '0',
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
            // if (isShowDelete.value)
            //   Container(
            //     decoration: BoxDecoration(
            //       color: Color(0xFFD83B35),
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     child: IconButton(
            //       style: ButtonStyle(
            //         padding: MaterialStateProperty.all(EdgeInsets.zero),
            //         // fixedSize: MaterialStateProperty.all(Size(24, 24)),
            //         shape: MaterialStateProperty.all(
            //           RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(8),
            //           ),
            //         ),
            //         minimumSize: MaterialStateProperty.all(Size(24, 24)),
            //       ),
            //       onPressed: () {
            //         // ref.read(cartProvider.notifier).deleteCart(orderLine.id ?? 0);
            //       },
            //       icon: Icon(
            //         Icons.delete,
            //         color: Colors.white,
            //         size: 24,
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}

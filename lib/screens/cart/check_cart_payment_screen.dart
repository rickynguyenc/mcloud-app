import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mcloud/core/app_route/app_route.dart';
import 'package:mcloud/core/utils/env.dart';
import 'package:mcloud/core/utils/extension/common_function.dart';
import 'package:mcloud/core/utils/widgets/loading_mark.dart';
import 'package:mcloud/models/cart_model.dart' as cart;
import 'package:mcloud/models/order_model.dart';
import 'package:mcloud/providers/cart_provider.dart';
import 'package:mcloud/providers/order_provider.dart';

@RoutePage()
class CheckCartPaymentScreen extends HookConsumerWidget {
  final List<cart.OrderLine> lstOrderLineChoosed;
  const CheckCartPaymentScreen(this.lstOrderLineChoosed);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollCtrlMain = useScrollController();
    final cartNotifier = ref.read(cartProvider.notifier);
    final totalValue = useState(0);
    final isLoading = useState(false);
    useEffect(() {
      lstOrderLineChoosed.forEach((element) {
        totalValue.value += element.priceUnit?.round() ?? 0;
      });
      return null;
    }, []);
    return Stack(children: [
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
                          'Kiểm tra đơn hàng',
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
                Expanded(
                  child: Scrollbar(
                    controller: scrollCtrlMain,
                    child: ListView.builder(
                      controller: scrollCtrlMain,
                      itemBuilder: (ctx, index) {
                        return ProductInCartElemnt(
                          lstOrderLineChoosed[index],
                          (orderLine) {
                            if (orderLine.productUomQty == 0) {
                              return;
                            }
                            cartNotifier.updateCart(orderLine.productId?.id ?? 0, (orderLine.productUomQty ?? 0) - 1);
                          },
                          (orderLine) {
                            cartNotifier.updateCart(orderLine.productId?.id ?? 0, (orderLine.productUomQty ?? 0) + 1);
                          },
                        );
                      },
                      itemCount: lstOrderLineChoosed.length,
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
                    '${NumberFormat('#,###', 'en_US').format(totalValue.value)}đ',
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
                child: ElevatedButton(
                  onPressed: () async {
                    isLoading.value = true;
                    final orderInput = AddOrderDto(againLink: 'https://shop-mobifone.tabcom.vn/order-detail/', orderLine: [
                      ...lstOrderLineChoosed
                          .map((e) => OrderLineDto(
                                productTemplateId: e.id ?? 0,
                                productTemplateAttributeValueIds: e.productId?.productTemplateAttributeValueIds ?? [],
                                productUomQty: e.productUomQty ?? 0,
                                priceUnit: e.priceUnit ?? 0,
                              ))
                          .toList()
                    ]);
                    final result = await ref.read(orderProvider.notifier).addToOrder(orderInput);
                    isLoading.value = false;
                    if (result?.urlPayment != null && result?.urlPayment != '') {
                      context.router.push(PaymentViewRoute(linkOnePay: result?.urlPayment ?? ''));
                    } else {
                      CommonFunction.showSnackBar('Xảy ra lỗi trong quá trình tạo đơn hàng', context, Colors.red);
                    }
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
      isLoading.value ? Loading() : const SizedBox.shrink(),
    ]);
  }
}

// cart Element
class ProductInCartElemnt extends HookConsumerWidget {
  final cart.OrderLine orderLine;
  final Function(cart.OrderLine) onRemove;
  final Function(cart.OrderLine) onAdd;
  const ProductInCartElemnt(this.orderLine, this.onRemove, this.onAdd, {super.key});
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
                    Text(
                      'Số lượng: ${orderLine.productUomQty?.round()}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xFF212121),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    )
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

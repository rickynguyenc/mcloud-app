import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcloud/core/utils/widgets/shimmer_loading/common_simmer.dart';

import '../../providers/order_provider.dart';

@RoutePage()
class DetailOrderScreen extends HookConsumerWidget {
  final int orderId;
  const DetailOrderScreen(this.orderId, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(true);
    final orderDetail = ref.watch(orderProvider.notifier).detailOrder;
    useEffect(() {
      ref.read(orderProvider).getOrderDetail(orderId).then((value) {
        isLoading.value = false;
      });
      return null;
    }, const []);
    return isLoading.value
        ? Padding(padding: EdgeInsets.only(top: 48), child: CommonSimmer())
        : Scaffold(
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
                            'Thông tin đơn hàng',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      SizedBox(width: 64)
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Đơn hàng số: #${orderDetail.order?[0].id}',
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Trạng thái: ${orderDetail.order?[0].status == 'paid' ? 'Đã thanh toán' : 'Chờ thanh toán'}',
                        style: TextStyle(
                          color: Color(0xFF212121),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'SẢN PHẨM ĐÃ MUA',
                        style: TextStyle(
                          color: Color(0xFFBDBDBD),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: orderDetail.order?.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tên sản phẩm: ${orderDetail.order?[index].orderLine?[0].productId?.name ?? ''}',
                                  style: TextStyle(
                                    color: Color(0xFF212121),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Mã key: ${orderDetail.order?[index].orderLine?[0].productKey ?? ''}',
                                  style: TextStyle(
                                    color: Color(0xFF212121),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Số lượng: ${orderDetail.order?[index].orderLine?[0].productUomQty?.round()}',
                                  style: TextStyle(
                                    color: Color(0xFF212121),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Giá: ${orderDetail.order?[index].orderLine?[0].priceUnit} vnđ',
                                  style: TextStyle(
                                    color: Color(0xFF212121),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 12),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

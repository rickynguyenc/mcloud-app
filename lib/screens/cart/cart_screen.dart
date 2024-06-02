import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcloud/core/app_route/app_route.dart';
import 'package:mcloud/core/utils/env.dart';
import 'package:mcloud/providers/cart_provider.dart';

import '../../core/utils/widgets/shimmer_loading/common_simmer.dart';

@RoutePage()
class CartScreen extends HookConsumerWidget {
  const CartScreen();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollCtrlMain = useScrollController();
    final cartLstProduct = ref.watch(cartProvider);
    final isLoading = useState(true);
    useEffect(() {
      ref.read(cartProvider.notifier).getCart().then((value) => isLoading.value = false);
      return null;
    }, const []);
    return isLoading.value
        ? CommonSimmer()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Scrollbar(
                controller: scrollCtrlMain,
                child: SingleChildScrollView(
                  controller: scrollCtrlMain,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24),
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
                      ListView.builder(
                        itemBuilder: (ctx, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 16),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x0F000000),
                                  blurRadius: 16,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: NetworkImage('${Environment.apiUrl}${cartLstProduct[index].orderLine?[0].productId?.avatarUrl ?? ''}'),
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
                                        cartLstProduct[index].orderLine?[0].productId?.name ?? '',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Số lượng: ${cartLstProduct[index].orderLine?[0].productUomQty ?? 0}',
                                        style: TextStyle(fontSize: 14, color: Color(0xffA5A5AB)),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Giá: ${cartLstProduct[index].orderLine?[0].priceUnit ?? 0}đ',
                                        style: TextStyle(fontSize: 14, color: Color(0xffA5A5AB)),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.add,
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      '1',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.remove,
                                          size: 24,
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: cartLstProduct.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomSheet: Container(
              height: 100,
              padding: EdgeInsets.all(16),
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
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tổng cộng',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '1 sản phẩm',
                          style: TextStyle(fontSize: 14, color: Color(0xffA5A5AB)),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '100.000đ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.router.push(CheckCartPaymentRoute());
                    },
                    child: Text('Thanh toán'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffFF6C44),
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}

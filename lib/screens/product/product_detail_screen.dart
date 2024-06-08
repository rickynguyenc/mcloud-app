import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mcloud/core/app_route/app_route.dart';
import 'package:mcloud/core/utils/env.dart';
import 'package:mcloud/core/utils/extension/common_function.dart';
import 'package:mcloud/core/utils/widgets/loading_mark.dart';
import 'package:mcloud/core/utils/widgets/product_item_in_grid_widget.dart';
import 'package:mcloud/models/cart_model.dart';
import 'package:mcloud/models/home_model.dart';
import 'package:mcloud/providers/cart_provider.dart';
import 'package:mcloud/providers/product_detail_provider.dart';

import '../../core/utils/widgets/shimmer_loading/common_simmer.dart';

@RoutePage()
class ProductDetailScreen extends HookConsumerWidget {
  final int productId;
  const ProductDetailScreen(this.productId);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollCtrl = useScrollController();
    final scrollCtrlMain = useScrollController();
    final detailProduct = ref.watch(productDetailProvider);
    final allProductInCart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final isLoading = useState(true);
    final mainMedia = useState('');
    final isRequesting = useState(false);
    useEffect(() {
      Future.wait([
        ref.read(productDetailProvider.notifier).getDetailProduct(productId).then((value) {
          isLoading.value = false;
          if (value != null) {
            mainMedia.value = value.result?[0].avatarUrl ?? '';
          }
        }),
        cartNotifier.getCart(),
      ]);
      return null;
    }, const []);
    return isLoading.value
        ? CommonSimmer()
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
                        Container(
                          width: 48,
                          height: 48,
                          child: IconButton(
                            // padding: EdgeInsets.zero,
                            // constraints: BoxConstraints(maxWidth: 48, maxHeight: 48),
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(Size(48, 48)),
                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                            ),
                            onPressed: () {
                              AutoRouter.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 24,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF4F6F9), elevation: 0, shadowColor: Colors.transparent, fixedSize: Size(double.infinity, 52)),
                            onPressed: () {
                              context.router.push(SearchProductRoute());
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/search-normal.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: SizedBox(
                                    child: Text(
                                      'Search...',
                                      style: TextStyle(
                                        color: Color(0xFF94A3B8),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                SvgPicture.asset(
                                  'assets/icons/horizontal-container.svg',
                                  width: 24,
                                  height: 24,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        // Cart button
                        Stack(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              child: IconButton(
                                  // padding: EdgeInsets.zero,
                                  // constraints: BoxConstraints(maxWidth: 48, maxHeight: 48),
                                  style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all(Size(48, 48)),
                                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                                  ),
                                  onPressed: () {
                                    context.router.push(CartRoute());
                                  },
                                  icon: SvgPicture.asset(
                                    'assets/icons/bag-2.svg',
                                    width: 24,
                                    height: 24,
                                  )),
                            ),
                            Positioned(
                              left: 30,
                              top: 6,
                              child: Container(
                                width: 16,
                                height: 16,
                                alignment: Alignment.center,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFD83B35),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  allProductInCart.isNotEmpty ? allProductInCart[0].orderLine?.length.toString() ?? '' : '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Expanded(
                        child: Scrollbar(
                      controller: scrollCtrlMain,
                      child: SingleChildScrollView(
                        controller: scrollCtrlMain,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image.network(
                                '${Environment.apiUrl}/${mainMedia.value}',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Text('Image not found'),
                                  );
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              alignment: Alignment.center,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Scrollbar(
                                      controller: scrollCtrl,
                                      thumbVisibility: true,
                                      child: SingleChildScrollView(
                                        physics: AlwaysScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        controller: scrollCtrl,
                                        child: Row(children: [
                                          InkWell(
                                            onTap: () {
                                              mainMedia.value = detailProduct.avatarUrl ?? '';
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                border: Border.all(color: mainMedia.value == detailProduct.avatarUrl ? Colors.blue : Colors.transparent, width: 2),
                                              ),
                                              margin: EdgeInsets.only(right: 8),
                                              width: 80,
                                              child: AspectRatio(
                                                aspectRatio: 1.4,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Image.network(
                                                    '${Environment.apiUrl}/${detailProduct.avatarUrl ?? ''}',
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return Center(
                                                        child: Text('Image not found'),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          ...detailProduct.productTemplateImageIds
                                                  ?.map(
                                                    (e) => InkWell(
                                                      onTap: () {
                                                        mainMedia.value = e;
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          border: Border.all(color: mainMedia.value == e ? Colors.blue : Colors.transparent, width: 2),
                                                        ),
                                                        margin: EdgeInsets.only(right: 8),
                                                        width: 80,
                                                        child: AspectRatio(
                                                          aspectRatio: 1.4,
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(10),
                                                            child: Image.network(
                                                              '${Environment.apiUrl}/$e',
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (context, error, stackTrace) {
                                                                return Center(
                                                                  child: Text('Image not found'),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList() ??
                                              []
                                        ]),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Text(
                                  '${NumberFormat('#,###', 'en_US').format(detailProduct.listPrice?.round())}đ',
                                  style: TextStyle(
                                    color: Color(0xFF055FA7),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '${NumberFormat('#,###', 'en_US').format(detailProduct.listPrice?.round())}đ',
                                  style: TextStyle(fontSize: 16, color: Colors.red, decoration: TextDecoration.lineThrough),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              detailProduct.name ?? '',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.yellow, size: 12),
                                SizedBox(width: 4),
                                Icon(Icons.star, color: Colors.yellow, size: 12),
                                SizedBox(width: 4),
                                Icon(Icons.star, color: Colors.yellow, size: 12),
                                SizedBox(width: 4),
                                Icon(Icons.star, color: Colors.yellow, size: 12),
                                SizedBox(width: 4),
                                Icon(Icons.star_border_outlined, color: Colors.white, size: 12),
                                SizedBox(width: 4),
                                Text(
                                  '4.7',
                                  style: TextStyle(
                                    color: Color(0xFF212121),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '(130)',
                                  style: TextStyle(
                                    color: Color(0xFF616161),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  '|',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  '239 đã bán',
                                  style: TextStyle(
                                    color: Color(0xFF616161),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: OvalBorder(),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x14000000),
                                        blurRadius: 6.80,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      // padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                      elevation: MaterialStateProperty.all(0),
                                      shadowColor: MaterialStateProperty.all(Color(0x14000000)),
                                    ),
                                    icon: Icon(
                                      Icons.link_outlined,
                                      size: 18,
                                      color: Color(0xff616161),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: OvalBorder(),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x14000000),
                                        blurRadius: 6.80,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      // padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                      elevation: MaterialStateProperty.all(0),
                                      shadowColor: MaterialStateProperty.all(Color(0x14000000)),
                                    ),
                                    icon: Icon(
                                      Icons.favorite,
                                      size: 18,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                )
                              ],
                            ),
                            SizedBox(height: 32),
                            Text(
                              'Thông tin chi tiết',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 16),
                            Html(
                              data: detailProduct.description.toString(),
                            ),
                            SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Sản phẩm tương tự',
                                  style: TextStyle(
                                    color: Color(0xFF212121),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Xem tất cả',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Color(0xFF055FA7),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.20,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Container(
                              padding: EdgeInsets.only(
                                top: 12,
                              ),
                              color: Colors.white,
                              child: GridView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // This creates 2 elements in a row
                                  childAspectRatio: 0.6,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                ),
                                itemCount: 3, // Replace with your list of games
                                itemBuilder: (BuildContext context, int index) {
                                  return ProductItemInGridWidget(Product(
                                    id: 1,
                                    name: 'Product name',
                                    listPrice: 100000,
                                    avatarUrl: '',
                                  ));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              bottomSheet: Container(
                height: 64,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/message-text.svg',
                            width: 24,
                            height: 24,
                          ),
                          Text(
                            'Chat',
                            style: TextStyle(color: Color(0xFF717171), fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: ShapeDecoration(
                          color: Color(0xFF055FA7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF055FA7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          onPressed: () {
                            isRequesting.value = true;
                            final inputDto = CartInputDto(orderLine: [
                              OrderLineDto(
                                productTemplateId: detailProduct.id,
                                productTemplateAttributeValueIds: detailProduct.attributeLineIds
                                    ?.map((e) => ProductTemplateAttributeValueIdsDto(
                                          attributeId: e.attributeId?.id,
                                          productAttributeValueId: e.id,
                                        ))
                                    .toList(),
                                priceUnit: detailProduct.listPrice,
                                productUomQty: 1,
                              )
                            ]);
                            cartNotifier.addToCart(inputDto).then((value) {
                              cartNotifier.getCart();
                              isRequesting.value = false;
                              CommonFunction.showSnackBar('Sản phẩm đã được thêm vào giỏ', context, Colors.green);
                            });
                          },
                          child: Text(
                            'Thêm vào giỏ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: ShapeDecoration(
                          color: Color(0xFFD83B35),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFD83B35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Mua ngay',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            isRequesting.value ? Loading() : const SizedBox.shrink(),
          ]);
  }
}

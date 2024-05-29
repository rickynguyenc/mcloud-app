import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcloud/core/utils/env.dart';
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
    final isLoading = useState(true);
    useEffect(() {
      ref.read(productDetailProvider.notifier).getDetailProduct(productId).then((value) => isLoading.value = false);
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
                                'Chi tiết sản phẩm',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          // Cart button
                          IconButton(
                            onPressed: () {
                              AutoRouter.of(context).pushNamed('/cart');
                            },
                            icon: Icon(Icons.shopping_cart_outlined),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      AspectRatio(
                        aspectRatio: 16 / 9,
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
                                    ...detailProduct.productTemplateImageIds
                                            ?.map(
                                              (e) => InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  margin: EdgeInsets.only(right: 8),
                                                  width: 80,
                                                  child: AspectRatio(
                                                    aspectRatio: 1.4,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(10),
                                                      child: Image.network(
                                                        '${Environment.apiUrl}/${e}',
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
                      Text(
                        'Price: ${detailProduct.listPrice ?? ''}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      Text(
                        detailProduct.name ?? '',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Text(
                        detailProduct.description.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomSheet: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Add to cart'),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Buy now'),
                      ),
                    ),
                  ],
                )));
  }
}

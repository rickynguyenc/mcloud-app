import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mcloud/core/app_route/app_route.dart';
import 'package:mcloud/core/utils/env.dart';
import 'package:mcloud/core/utils/widgets/search_widget.dart';
import 'package:mcloud/core/utils/widgets/shimmer_loading/common_simmer.dart';
import 'package:mcloud/core/utils/widgets/sliderbar_widget.dart';
import 'package:mcloud/models/quote_model.dart';
import 'package:mcloud/providers/home_provider.dart';
import 'package:mcloud/providers/quote_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class SearchProductScreen extends HookConsumerWidget {
  final _scrollCtrl = ScrollController();
  void _refresh(WidgetRef ref) {
    ref.read(homeProvider.notifier).getListProducts();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lstProduct = ref.watch(homeProvider);
    final isLoading = useState(true);
    useEffect(() {
      ref.read(homeProvider.notifier).getListProducts().then((value) => isLoading.value = false);
      return null;
    }, const []);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF5F5F5),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 48),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
              // SizedBox(width: 16),
              Expanded(
                child: SearchBarWidget(
                  textSearch: '',
                  hintText: 'Search...',
                  onChanged: (value) {},
                  onSubmit: (value) {},
                ),
              ),
            ]),
            SizedBox(height: 24),
            Container(
              height: 54,
              padding: EdgeInsets.symmetric(horizontal: 16),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Phù hợp nhất',
                    style: TextStyle(
                      color: Color(0xFFD83B35),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 13.5),
                  Text(
                    'Bán chạy',
                    style: TextStyle(
                      color: Color(0xFF858585),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 13.5),
                  Text(
                    'Giá↑',
                    style: TextStyle(
                      color: Color(0xFF858585),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 1.35,
                    height: 30.33,
                    decoration: BoxDecoration(color: Color(0xFFD9D9D9)),
                  ),
                  SizedBox(width: 20),
                  Icon(Icons.filter_alt_outlined, color: Color(0xFF858585), size: 24),
                  Text(
                    'Lọc',
                    style: TextStyle(
                      color: Color(0xFF616161),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: isLoading.value
                  ? CommonSimmer()
                  : lstProduct.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage('assets/images/no_data.png'),
                                width: 200,
                                height: 200,
                              ),
                            ),
                            Text(
                              'Không tìm thấy kết quả nào',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Chúng tôi không thể tìm thấy những gì bạn tìm kiếm hãy thử tìm lại với từ khóa khác',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF646568),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      : Scrollbar(
                          controller: _scrollCtrl,
                          child: SingleChildScrollView(
                            controller: _scrollCtrl,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 12,
                                  ),
                                  color: Color(0xffF7F7F7),
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
                                    itemCount: lstProduct.length, // Replace with your list of games
                                    itemBuilder: (BuildContext context, int index) {
                                      return Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () {
                                            AutoRouter.of(context).push(ProductDetailRoute(productId: int.parse(lstProduct[index].id.toString())));
                                          },
                                          child: Container(
                                            // height: 48,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(5.89),
                                              // color: Colors.blueGrey,
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                AspectRatio(
                                                  aspectRatio: 1,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: Image.network(
                                                      '${Environment.apiUrl}/${lstProduct[index].avatarUrl ?? ''}',
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
                                                          lstProduct[index].name ?? '',
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
                                                                text: '200.000đ',
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
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 24)
                                // Lst  product
                                // ...lstProduct.map((e) => ProductElement()).toList(),
                              ],
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

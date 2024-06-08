import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcloud/services/product_service.dart';

import '../models/product_model.dart';

final productDetailProvider = StateNotifierProvider<ProductDetailProvider, ProductDetail>((ref) {
  return ProductDetailProvider(ref);
});

class ProductDetailProvider extends StateNotifier<ProductDetail> {
  final Ref ref;
  ProductDetailProvider(this.ref) : super(ProductDetail());
  late final _productDetailService = ref.read(productServiceProvider);
  Future<ProductDetailResponse?> getDetailProduct(int id) async {
    try {
      final result = await _productDetailService.getProduct(id);
      state = result.result?[0] ?? ProductDetail();
      return result;
    } catch (e) {
      return null;
    }
  }
}

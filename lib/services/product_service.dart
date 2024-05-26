import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcloud/models/product_model.dart';
import 'package:retrofit/http.dart';

import '../core/app_dio.dart';
part 'product_service.g.dart';

final productServiceProvider = Provider<ProductService>((ref) {
  return ProductService(ref);
});

@RestApi()
abstract class ProductService {
  factory ProductService(Ref ref) => _ProductService(ref.read(dioProvider));
  @GET('/api/product_template/{id}')
  Future<ProductDetailResponse> getProduct(@Path('id') int id);
}

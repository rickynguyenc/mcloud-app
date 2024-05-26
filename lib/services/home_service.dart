import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/http.dart';

import '../core/app_dio.dart';
import '../models/home_model.dart';
part 'home_service.g.dart';

final homeServiceProvider = Provider<HomeService>((ref) {
  return HomeService(ref);
});

@RestApi()
abstract class HomeService {
  factory HomeService(Ref ref) => _HomeService(ref.read(dioProvider));
  @GET('/api/product_template')
  Future<ListProductResponse> getListProducts();
  @GET('/api/product_category')
  Future<CategoryProductResponse> getListCategories();
}

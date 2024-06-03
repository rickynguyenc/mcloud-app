import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/http.dart';

import '../core/app_dio.dart';
import '../models/cart_model.dart'; // replace with your actual cart model
part 'cart_service.g.dart';

final cartServiceProvider = Provider<CartService>((ref) {
  return CartService(ref);
});

@RestApi()
abstract class CartService {
  factory CartService(Ref ref) => _CartService(ref.read(dioProvider));

  @POST('/api/shop/add_to_cart')
  Future<dynamic> addToCart(@Body() CartInputDto body); // replace with your actual request body

  @GET('/api/shop/cart')
  Future<AllProductionInCartResponse> getCart(); // replace with your actual response type

  @PUT('/api/shop/update_cart')
  Future<dynamic> updateCart(@Body() Map<String, dynamic> body);
}

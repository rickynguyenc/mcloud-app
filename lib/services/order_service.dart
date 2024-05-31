import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcloud/models/order_model.dart';
import 'package:retrofit/http.dart';

import '../core/app_dio.dart';
part 'order_service.g.dart';

final orderServiceProvider = Provider<OrderService>((ref) {
  return OrderService(ref);
});

@RestApi()
abstract class OrderService {
  factory OrderService(Ref ref) => _OrderService(ref.read(dioProvider));

  @POST('/api/sale_order')
  Future<AddOrderResponse> addToOrder(@Body() AddOrderDto body);

  @GET('/api/sale_order')
  Future<AllOrderResponse> getOrder();

  @GET('/api/sale_order/{id}')
  Future<DetailOrderResponse> getOrderDetail(@Path('id') int id);

  @GET('/api/sale_order/payment/{id}')
  Future<dynamic> confirmOrder(@Path('id') int id);
}

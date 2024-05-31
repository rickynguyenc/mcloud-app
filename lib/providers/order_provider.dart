import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcloud/models/order_model.dart';
import 'package:mcloud/services/order_service.dart';

final orderProvider = ChangeNotifierProvider<OrderNotifier>((ref) {
  return OrderNotifier(ref);
});

class OrderNotifier extends ChangeNotifier {
  final Ref ref;
  OrderNotifier(this.ref);
  List<OrderItem?> _lstOrderItem = [];
  List<OrderItem?> get lstOrderItem => _lstOrderItem;
  DetailOrder _detailOrder = DetailOrder();
  DetailOrder get detailOrder => _detailOrder;
  late final _orderService = ref.read(orderServiceProvider);
  Future<bool> getOrder() async {
    try {
      final response = await _orderService.getOrder();
      _lstOrderItem = response.result ?? [];
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getOrderDetail(int id) async {
    try {
      final response = await _orderService.getOrderDetail(id);
      _detailOrder = response.result ?? DetailOrder();
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> confirmOrder(int id) async {
    try {
      await _orderService.confirmOrder(id);
      await getOrder();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<ResultAddOrder?> addToOrder(AddOrderDto orderDto) async {
    try {
      final result = await _orderService.addToOrder(orderDto);
      return result.result;
    } catch (e) {
      return null;
    }
  }
}

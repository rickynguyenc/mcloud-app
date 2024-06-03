import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart_model.dart';
import '../services/cart_service.dart';

// Define the CartNotifier
class CartNotifier extends StateNotifier<List<ProductInCart>> {
  final Ref ref;
  CartNotifier(this.ref) : super([]);
  late final _cartService = ref.read(cartServiceProvider);
  Future<bool> getCart() async {
    try {
      final response = await _cartService.getCart();
      state = response.result ?? [];
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addToCart(CartInputDto cartDto) async {
    try {
      await _cartService.addToCart(cartDto);
      await getCart();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateCart(num productId, num productUomQty) async {
    try {
      await _cartService.updateCart({'product_id': productId.round(), 'product_uom_qty': productUomQty.round()});
      await getCart();
      return true;
    } catch (e) {
      return false;
    }
  }
}

// Define the CartProvider
final cartProvider = StateNotifierProvider<CartNotifier, List<ProductInCart>>((ref) => CartNotifier(ref));

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/home_model.dart';
import '../services/home_service.dart';

final homeProvider = StateNotifierProvider<HomeProvider, List<Product>>((ref) {
  return HomeProvider(ref);
});

class HomeProvider extends StateNotifier<List<Product>> {
  final Ref ref;
  HomeProvider(this.ref) : super([]);
  late final _homeService = ref.read(homeServiceProvider);
  Future<void> getListProducts() async {
    try {
      final result = await _homeService.getListProducts();
      state = result.result ?? [];
    } catch (e) {
      print(e);
    }
  }
}

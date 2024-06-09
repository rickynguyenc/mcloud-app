import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcloud/models/user_infor_model.dart';
import 'package:mcloud/services/auth_service.dart';

final userInforProvider = StateNotifierProvider<UserInforNotifier, UserInfor>((ref) {
  return UserInforNotifier(ref);
});

class UserInforNotifier extends StateNotifier<UserInfor> {
  final Ref ref;
  UserInforNotifier(this.ref) : super(UserInfor());
  late final _authService = ref.read(authServiceProvider);

  Future<bool> getUserInfor(int idUser) async {
    try {
      final response = await _authService.getUserInfor(idUser);
      if (response.result != null && response.result!.isNotEmpty) {
        state = response.result![0];
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}

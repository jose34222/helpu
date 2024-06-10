
import 'package:get/get.dart';
import 'package:helpu/src/features/authetication/model/user_model.dart';
import 'package:helpu/src/repository/authentication_repository/authentication_repository.dart';
import 'package:helpu/src/repository/user_repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.find<AuthenticationRepository>();
  final _userRepo = Get.find<UserRepository>();

  getUserDetails() async {
    final email = _authRepo.firebaseUser.value?.email;

    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar('Error', 'Login to get user details');
    }
  }

  Future<List<UserModel>> getUsers() async {
    return await _userRepo.getUsers();
  }

  updateUser(UserModel user) async {
    await _userRepo.updateUser(user);
  }
}
import 'package:get/get.dart';
import 'package:testimpack/models/user_details_model.dart';
import 'package:testimpack/models/user_list_model.dart';
import 'package:testimpack/services/api_services.dart';

class DataController extends GetxController {
  var userData = <UserList>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    getUserList();
    super.onInit();
  }

  void getUserList() async {
    try {
      isLoading(true);
      var dataUser = await ApiServices().getListData();

      userData.assignAll(dataUser);
    } finally {
      isLoading(false);
    }
  }
}

class DetailsController extends GetxController {
  var userData = UserDetails().obs;
  var isLoading = true.obs;
  var id = '1'.obs;

  @override
  void onInit() {
    getUserDetails(id.toString());
    super.onInit();
  }

  void getUserDetails(String id) async {
    try {
      isLoading(true);
      var detailsUser = await ApiServices().getIdData(id);
      userData.value = detailsUser;
    } finally {
      isLoading(false);
    }
  }
}

class IsOpenController extends GetxController {
  var isOpen = true.obs;

  void openTask() {
    isOpen(true);
    update();
  }

  void completeTask() {
    isOpen(false);
    update();
  }
}

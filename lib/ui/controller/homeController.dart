import 'package:get/get.dart';
import 'package:tripsync_v3/ui/controller/groupController.dart';
import 'package:tripsync_v3/ui/controller/loginController.dart';
import 'package:tripsync_v3/ui/model/chat.dart';
import 'package:tripsync_v3/utils.dart';

class HomeController extends GetxController {
  LoginController loginController = Get.find<LoginController>();
  GroupController groupController = Get.find<GroupController>();
  RxInt currentIndex = 0.obs;

}
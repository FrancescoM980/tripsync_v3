import 'package:get/get.dart';
import 'package:tripsync_v3/ui/controller/loginController.dart';
import 'package:tripsync_v3/ui/model/chat.dart';
import 'package:tripsync_v3/utils.dart';

class HomeController extends GetxController {
  LoginController loginController = Get.find<LoginController>();
  late final Stream<List<Chat>> messagesStream;
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final myUserId = loginController.currentUser.id;
    messagesStream = TripUtils.supabase
      .from('chat')
      .stream(primaryKey: ['id'])
      .inFilter('group_id', [])
      .order('created_at')

      .map((maps) => maps
        .map((map) => Chat.fromMap(
          map,
          myUserId
        ))
      .toList());
  }
}
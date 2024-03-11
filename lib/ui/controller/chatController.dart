import 'package:get/get.dart';
import 'package:tripsync_v3/ui/controller/groupController.dart';
import 'package:tripsync_v3/ui/controller/loginController.dart';
import 'package:tripsync_v3/ui/model/chat.dart';
import 'package:tripsync_v3/ui/model/group.dart';
import 'package:tripsync_v3/utils.dart';

class ChatController extends GetxController {
  LoginController loginController = Get.find<LoginController>();
  GroupController groupController = Get.find<GroupController>();
  RxList<Chat> myLastChat = <Chat>[].obs;
  late final Stream<List<Chat>> messagesStream;
  
  @override
  void onInit() {
    super.onInit();
    final myUserId = loginController.currentUser.id;
    print(groupController.myGroups.map((element) => element.id).toList());
    messagesStream = TripUtils.supabase
      .from('chat')
      .stream(primaryKey: ['id'])
      .inFilter('group_id', groupController.myGroups.map((element) => element.id).toList()
      )
      .order('created_at')

      .map((maps) => maps
        .map((map) => Chat.fromMap(
          map,
          myUserId
        ))
      .toList());
  }

  Future<void> getMyLast() async {
    List<Chat> chats = await getLastMessageForGroups(groupController.myGroups);
    
    // Ordinamento delle chat in base a 'created_at' in ordine decrescente
    chats.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    myLastChat.value = chats;
    update();
  }

  Future<List<Chat>> getLastMessageForGroups(List<Group> groups) async {
    var groupIds = groups.map((g) => g.id).toList();
    Map<int, String> groupIdToName = {};
    for (var group in groups) {
      groupIdToName[group.id] = group.title;
    }

    var response = await TripUtils.supabase
      .rpc('get_last_messages', params: {'group_ids': groupIds});

      List<Chat> chats = [for (var data in response) Chat.fromMap(data, loginController.currentUser.id)];

      for (var chat in chats) {
        var readResponse = await TripUtils.supabase
          .from('message_views')
          .select()
          .eq('group_id', chat.groupId)
          .eq('user_id', loginController.currentUser.id)
          .order('message_id', ascending: false)
          .limit(1);
        int messageId = 0;
        if (readResponse.isNotEmpty) {
          messageId = readResponse[0]['message_id'];
        } 
        chat.isRead = chat.id == messageId;
        chat.groupName = groupIdToName[chat.groupId];
      }

      return chats;
  }
}
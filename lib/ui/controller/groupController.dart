import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:tripsync_v3/ui/controller/loginController.dart';
import 'package:tripsync_v3/ui/model/group.dart';
import 'package:tripsync_v3/utils.dart';

class GroupController extends GetxController {
  LoginController loginController = Get.find<LoginController>();
  RxBool isLoadingFetchMyGroups = false.obs;
  late final Stream<List<String>> myGroupStream;
  RxList<Group> myGroups = <Group>[].obs;

  @override
  void onInit() {
    super.onInit();
    final myUserId = loginController.currentUser.id;
    myGroupStream = TripUtils.supabase
      .from('usergroup')
      .stream(primaryKey: ['id'])
      .eq('id_user', myUserId)
      .map((maps) => maps
        .map((map) => '${map['id_group']}'
        )
      .toList());
  }

  Future<void> fetchMyGroups() async {
    isLoadingFetchMyGroups.value = true;
    final res = await TripUtils.supabase
                  .from('vw_usergroups')
                  .select('*')
                  .eq('id_user', loginController.currentUser.id)
                  .order('created_at');
    myGroups.value = res.map(
      (e) => Group.fromMap(e)
    ).toList();
    isLoadingFetchMyGroups.value = false;
  }
}
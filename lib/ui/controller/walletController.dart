import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:tripsync_v3/utils.dart';

class WalletController extends GetxController {
  RxList<Debitor> debitors = <Debitor>[].obs;
  Future<void> getDebt() async {
    debitors.clear();
    final res = await TripUtils.supabase.rpc('get_debt', params: {'group_id_input': 192});
    for (var r in res) {
      debitors.add(
        Debitor(
          userIdDebitor: r['useriddebt'], 
          nicknameDebitor: r['nicknamedebt'], 
          valueDebt: r['valuedebt'].toString().toDouble(), 
          receiverId: r['receiverid']
        )
      );
    }
  }
}

class Debitor {
  int userIdDebitor;
  String nicknameDebitor;
  double valueDebt;
  int receiverId;


  Debitor({
    required this.userIdDebitor,
    required this.nicknameDebitor,
    required this.valueDebt,
    required this.receiverId
  });
}
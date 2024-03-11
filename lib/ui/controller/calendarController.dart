import 'package:get/get.dart';
import 'package:tripsync_v3/ui/controller/loginController.dart';
import 'package:tripsync_v3/ui/model/personal_date_calendar.dart';
import 'package:tripsync_v3/utils.dart';

class CalendarController extends GetxController {
  LoginController loginController = Get.find<LoginController>();

  RxBool isLoadingFetchMyCalendar = false.obs;
  RxList<PersonalDateCalendar> myCalendar = <PersonalDateCalendar>[].obs;
  List<DateTime> dateOccupate = [];
  List<DateTime> dateProvvisorie = [];

  @override
  void onInit() {
    fetchMyCalendar();
  }


  Future<void> fetchMyCalendar() async {
    isLoadingFetchMyCalendar.value = true;
    dateOccupate = [];
    dateProvvisorie = [];
    final res = await TripUtils.supabase
                  .from('vw_user_dates')
                  .select('*')
                  .eq('user_id', loginController.currentUser.id);
    myCalendar.value = res.map(
      (e) => PersonalDateCalendar.fromMap(e)
    ).toList();
    for (PersonalDateCalendar tmp in myCalendar) {
      tmp.isMyChoice
        ? dateProvvisorie.addAll(getDateTimeList(tmp.startDate, tmp.endDate))
        : dateOccupate.addAll(getDateTimeList(tmp.startDate, tmp.endDate));
    }
    isLoadingFetchMyCalendar.value = false;
  }

  List<DateTime> getDateTimeList(DateTime startDate, DateTime endDate) {
    final duration = endDate.difference(startDate);
    final days = duration.inDays;

    return List.generate(days, (index) => startDate.add(Duration(days: index)));
  }
}
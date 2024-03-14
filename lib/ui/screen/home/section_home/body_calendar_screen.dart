import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:clean_calendar/clean_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:timeago/timeago.dart';
import 'package:tripsync_v3/ui/common_widget/common_form_field.dart';
import 'package:tripsync_v3/ui/common_widget/obx_body.dart';
import 'package:tripsync_v3/ui/common_widget/trip_scaffold.dart';
import 'package:tripsync_v3/ui/controller/calendarController.dart';
import 'package:tripsync_v3/ui/controller/chatController.dart';
import 'package:tripsync_v3/ui/controller/groupController.dart';
import 'package:tripsync_v3/ui/controller/homeController.dart';
import 'package:tripsync_v3/ui/controller/walletController.dart';
import 'package:tripsync_v3/ui/model/chat.dart';
import 'package:tripsync_v3/ui/model/group.dart';
import 'package:tripsync_v3/ui/screen/settings/settings_screen.dart';
import 'package:tripsync_v3/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BodyCalendar extends StatelessWidget {
  CalendarController calendarController = Get.find<CalendarController>();
  List<DateTime> selectedDates = [];
  BodyCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CleanCalendar(
            datePickerCalendarView: DatePickerCalendarView.monthView,
            enableDenseViewForDates: false,
            enableDenseSplashForDates: true,
            streakDatesProperties: DatesProperties(
              datesDecoration: DatesDecoration(
                datesBackgroundColor: Colors.red
              )
            ),
            leadingTrailingDatesProperties: DatesProperties(
              hide: true,
            ),
            startWeekday: WeekDay.monday,
            datesForStreaks: calendarController.dateOccupate + calendarController.dateProvvisorie,
            dateSelectionMode: DatePickerSelectionMode.singleOrMultiple,
            onCalendarViewDate: (DateTime calendarViewDate) {
              print(calendarViewDate);
            },
            selectedDates: selectedDates,
            onSelectedDates: (List<DateTime> value) {
                if (selectedDates.contains(value.first)) {
                  selectedDates.remove(value.first);
                } else {
                  selectedDates.add(value.first);
                }
            },
          ),
        ],
      )
    );
  }
}
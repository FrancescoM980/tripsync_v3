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

class BodyHomePage extends StatelessWidget {
  GroupController groupController = Get.find<GroupController>();

  BodyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: StreamBuilder<List<String>>(
        stream: groupController.myGroupStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              groupController.fetchMyGroups();
            });
            return Obx ( () =>
              Stack(
                children: [
                  ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: groupController.myGroups.length,
                    itemBuilder: (context, i) {
                      Group group = groupController.myGroups[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Card(
                          child: ListTile(
                            title: Text(group.title),
                            subtitle: Text(
                              '${group.people} ${AppLocalizations.of(context)!.partecipanti}',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.transparent,
                              child: Image.asset(
                                'assets/images/only_logo.png',
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  if (groupController.isLoadingFetchMyGroups.value)
                  Container(
                    height: MediaQuery.of(context).size.height/1,
                    width: MediaQuery.of(context).size.width/1,
                    color: Colors.transparent
                  ),
                  if (groupController.isLoadingFetchMyGroups.value)
                  SizedBox(
                    width: MediaQuery.of(context).size.width/1,
                    height: MediaQuery.of(context).size.height/1.25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LoadingAnimationWidget.inkDrop(
                          color: Theme.of(context).primaryColor, 
                          size: 30
                        ),
                        SizedBox(height: 15),
                        Text(AppLocalizations.of(context)!.loadingText)
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}')
            );
          } else {
            return SizedBox(height: 0);
          }
        },
      ),
      
    );
  }
}


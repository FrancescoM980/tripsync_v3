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

class BodyChatPage extends StatelessWidget {
  ChatController chatController = Get.find<ChatController>();
  BodyChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Stack(
        children: [
          Obx( () => 
            ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: chatController.myLastChat.length,
              itemBuilder: (context, i) {
                Chat chat = chatController.myLastChat[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      chat.groupName ?? '',
                      style: TextStyle(
                        fontWeight: chat.isRead == true ? null : FontWeight.bold
                      ),
                    ),
                    subtitle: Text(
                      '${chat.senderNick ?? 'N/A'}: ${chat.message}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: chat.isRead == true ? FontWeight.w300 : FontWeight.bold
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.transparent,
                      child: Image.asset(
                        'assets/images/only_logo.png',
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          format(
                            chat.createdAt, 
                            locale: 'it'
                          ),
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10)
                        ),
                        chat.isRead == true
                          ? SizedBox(height: 0)
                          : Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(25)
                            ),
                          ),
                        SizedBox(height: 0)
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (chatController.isLoadingMyLastChat.value)
          Container(
            height: MediaQuery.of(context).size.height/1,
            width: MediaQuery.of(context).size.width/1,
            color: Colors.transparent
          ),
          if (chatController.isLoadingMyLastChat.value)
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
                
              ],
            ),
          )
        ],
      )
    );
  }
}
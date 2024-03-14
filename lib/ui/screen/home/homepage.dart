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
import 'package:tripsync_v3/ui/screen/home/section_home/body_all_chat_screen.dart';
import 'package:tripsync_v3/ui/screen/home/section_home/body_calendar_screen.dart';
import 'package:tripsync_v3/ui/screen/home/section_home/body_home_screen.dart';
import 'package:tripsync_v3/ui/screen/home/section_home/body_wallet_screen.dart';
import 'package:tripsync_v3/ui/screen/settings/settings_screen.dart';
import 'package:tripsync_v3/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePageScreen extends StatelessWidget {
  GroupController groupController = Get.find<GroupController>();
  CalendarController calendarController = Get.put(CalendarController());
  WalletController walletController = Get.put(WalletController());
  ChatController chatController = Get.put(ChatController());
  RxBool isNewMessage = false.obs;

  void startAnimation() async {
    isNewMessage.value = true;
    chatController.update();
    await Future.delayed(Duration(seconds: 2), () {
      isNewMessage.value = false;
    });
    chatController.update();
  }
  HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    walletController.getDebt();
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 50,
            centerTitle: true,
            title: Container(
              width: 150,
              child: Image.asset(
                'assets/images/tripsync-3.png',
                color: Theme.of(context).primaryColor
              )
            ),
            leading: TextButton(
              onPressed: () {
                Get.to(
                  SettingScreen(),
                  transition: Transition.zoom
                );
              }, 
              child: Icon(
                Icons.settings,
                color: Theme.of(context).primaryColor,
                size: 25
              )
            ),
            actions: [
              TextButton(
                onPressed: () {
        
                }, 
                child: Icon(
                  Icons.notifications_active,
                  color: Theme.of(context).primaryColor,
                  size: 25
                )
              )
            ],
          ),
          body: Column(
            children: [
              Divider(height: 0),
              //CommonForm(
              //  titleText: 'Partenza', 
              //  icon: Icons.search, 
              //  paddingHorizontal: 10,
              //  onChanged: (p0) async {
              //    //await controller.fetchDirectFlights('SUF', 'LIN', '2024-04', '2024-04', '19f7f10a6c60d2808c9d2ec422502d39');
              //    await controller.fetchFlightSearchResults('1174');
              //    //await controller.searchFlight(p0);
              //    //await controller.searchAirport(p0);
              //  },
              //),
              Expanded(
                child: bodySection(controller.currentIndex.value)
              )
            ],
          ), 
          bottomNavigationBar: StreamBuilder<List<Chat>>(
            stream: chatController.messagesStream,
            builder: (BuildContext context, snapshot) {
              if (!chatController.isLoadingMyLastChat.value) {
                chatController.getMyLast();
              }
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                startAnimation();
              }
              return BottomBarDoubleBullet(
                height: 70,
                color: Theme.of(context).primaryColor,
                circle1Color: TripUtils.purpleChiaro,
                circle2Color: TripUtils.arancioneChiaro,
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor!,
                selectedIndex: controller.currentIndex.value,
                items: [
                  BottomBarItem(
                    iconData: Iconsax.home,
                    iconSize: 25
                  ),
                  BottomBarItem(
                    iconData: Iconsax.wallet,
                    iconSize: 25
                  ),
                  BottomBarItem(
                    iconData: Iconsax.add,
                    iconSize: 30,
                  ),
                  BottomBarItem(
                    iconData: Iconsax.calendar,
                    iconSize: 25
                  ),
                  BottomBarItem(
                    iconBuilder: (color) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              
                              Icon(
                                CupertinoIcons.chat_bubble_2_fill,
                                size: 30,
                                color: controller.currentIndex.value == 4
                                 ? Theme.of(context).primaryColor
                                 : Theme.of(context).dividerColor.withOpacity(0.50)
                              ),
                              Obx( () => chatController.myLastChat.where((p0) => p0.isRead == false).toList().isEmpty
                                ? SizedBox(height: 0, width: 0)
                                : Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.red,
                                      ),
                                      child: Text(
                                        '${chatController.myLastChat.where((p0) => p0.isRead == false).toList().length}',
                                      ),
                                    )
                                  )
                              )
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
                onSelect: (index) {
                  controller.currentIndex.value = index;
                  controller.update();
                },
                
              ); 
            }
          )
        );
      }
    );
  }

  Widget bodySection(int i) {
    switch (i) {
      case 0:
        return BodyHomePage();
      case 1:
        return BodyWallet();
      case 2:
        return BodyHomePage();
      case 3:
        return BodyCalendar();
      case 4:
        return BodyChatPage();
      default:
        return Center(
          child: Text('404 NOT FOUND'),
        );
    }
  }
}
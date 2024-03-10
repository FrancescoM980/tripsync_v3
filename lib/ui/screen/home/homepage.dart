import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tripsync_v3/ui/common_widget/obx_body.dart';
import 'package:tripsync_v3/ui/common_widget/trip_scaffold.dart';
import 'package:tripsync_v3/ui/controller/groupController.dart';
import 'package:tripsync_v3/ui/controller/homeController.dart';
import 'package:tripsync_v3/ui/model/chat.dart';
import 'package:tripsync_v3/ui/model/group.dart';
import 'package:tripsync_v3/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePageScreen extends StatelessWidget {
  GroupController groupController = Get.put(GroupController());
  HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        
              }, 
              child: Icon(
                Icons.settings,
                color: Theme.of(context).primaryColor,
                size: 30
              )
            ),
            actions: [
              TextButton(
                onPressed: () {
        
                }, 
                child: Icon(
                  Icons.notifications_active,
                  color: Theme.of(context).primaryColor,
                  size: 30
                )
              )
            ],
          ),
          body: Column(
            children: [
              Divider(),
              Expanded(
                child: bodySection(controller.currentIndex.value)
              )
            ],
          ), 
          bottomNavigationBar: StreamBuilder<List<Chat>>(
            stream: controller.messagesStream,
            builder: (BuildContext context, snapshot) {
              return BottomBarDoubleBullet(
                height: 90,
                color: Theme.of(context).primaryColor,
                circle1Color: TripUtils.purpleChiaro,
                circle2Color: TripUtils.arancioneChiaro,
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor!,
                selectedIndex: controller.currentIndex.value,
                items: [
                  BottomBarItem(
                    iconData: Iconsax.home
                  ),
                  BottomBarItem(
                    iconData: Iconsax.wallet
                  ),
                  BottomBarItem(
                    iconData: Iconsax.add,
                    iconSize: 40,
                  ),
                  BottomBarItem(
                    iconData: Iconsax.calendar
                  ),
                  BottomBarItem(
                    iconData: CupertinoIcons.chat_bubble_2_fill
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
        return BodyHomePage();
      case 4:
        return BodyHomePage();
      default:
        return Center(
          child: Text('404 NOT FOUND'),
        );
    }
  }
}












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
                            subtitle: Text('${group.people} ${AppLocalizations.of(context)!.partecipanti}'),
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




















class BodyWallet extends StatelessWidget {
  const BodyWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
            child: Row(
              children: [
                Text(
                  'Nel complesso devi ricevere ',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '33,84',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: false,
              itemCount: 15,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: ListTile(
                    onTap: () {
                      
                    },
                    title: Text('pippo'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'devi dare',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text('22,51')
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.transparent,
                      child: Icon(
                        Iconsax.moneys,
                        color: Colors.lightGreenAccent,
                      )
                    ),
                  ),
                );
              }
            ),
          ),
        ],
      )
    );
  }
}
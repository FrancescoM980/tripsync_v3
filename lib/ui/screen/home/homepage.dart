import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tripsync_v3/ui/common_widget/trip_scaffold.dart';
import 'package:tripsync_v3/ui/controller/homeController.dart';
import 'package:tripsync_v3/utils.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 50,
            title: SizedBox(
              height: 50,
              child: Image.asset(
                'assets/images/only_logo.png',
              )
            ),
            leading: TextButton(
              onPressed: () {

              }, 
              child: Icon(
                Icons.settings,
                color: Theme.of(context).dividerColor,
                size: 30
              )
            ),
            actions: [
              TextButton(
                onPressed: () {

                }, 
                child: Icon(
                  Icons.notifications_active,
                  color: Theme.of(context).dividerColor,
                  size: 30
                )
              )
            ],
          ),
          body: Column(
            children: [
              Divider(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ListView.builder(
                    shrinkWrap: false,
                    itemCount: 15,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Card(
                          child: ListTile(
                            title: Text('gruppo 14 tmp'),
                            subtitle: Text('5 partecipanti'),
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.transparent,
                              child: Image.asset(
                                'assets/images/only_logo.png',
                              ),
                            ),
                          )
                        ),
                      );
                    }
                  )
                ),
              ),
            ],
          ), 
          bottomNavigationBar: BottomBarDoubleBullet(
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
                iconSize: 30,
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
                ),
        );
      }
    );
  }
}
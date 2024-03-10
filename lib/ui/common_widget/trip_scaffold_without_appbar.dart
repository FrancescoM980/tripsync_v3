import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TripScaffoldWithoutAppBar extends StatelessWidget {
  Widget body;
  List<RxBool> loadingBool;
  TripScaffoldWithoutAppBar({
    super.key,
    required this.body,
    required this.loadingBool
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx( () => 
        Stack(
          children: [
            body,
            if (loadingBool.any((element) => element.value))
            Container(
              width: MediaQuery.of(context).size.width/1,
              height: MediaQuery.of(context).size.height/1,
              color: Theme.of(context).dividerColor.withOpacity(0.25)
            ),
            if (loadingBool.any((element) => element.value))
            SizedBox(
              width: MediaQuery.of(context).size.width/1,
              height: MediaQuery.of(context).size.height/1,
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
      )
    );
  }
}
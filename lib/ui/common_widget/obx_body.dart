import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tripsync_v3/ui/common_widget/loading_widget.dart';

class ObxBody extends StatelessWidget {
  Widget body;
  List<RxBool> loadingBool;
  ObxBody({
    super.key,
    required this.body,
    required this.loadingBool
  });

  @override
  Widget build(BuildContext context) {
    return Obx( () => 
      Stack(
        children: [
          body,
          if (loadingBool.any((element) => element.value))
          Container(
            width: MediaQuery.of(context).size.width/1,
            height: MediaQuery.of(context).size.height/1,
            color: Theme.of(context).dividerColor.withOpacity(0.0)
          ),
          if (loadingBool.any((element) => element.value))
          LoadingWidget()
        ],
      ),
    );
  }
}
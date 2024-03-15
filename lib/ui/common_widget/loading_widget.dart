import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
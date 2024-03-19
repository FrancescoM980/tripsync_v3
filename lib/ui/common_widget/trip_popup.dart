import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripsync_v3/utils.dart';


class TripPopup extends StatelessWidget {
  final String title;
  final Widget content;
  final bool? scrollable;
  //final Widget firstButton;
  //final Widget secondButton;
  final bool hasButtons;
  void Function()? onPressedConfirm;

  TripPopup({
    super.key, 
    required this.title, 
    required this.content, 
    this.scrollable, 
    this.hasButtons = true,
    this.onPressedConfirm
    //required this.firstButton,
    //required this.secondButton
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titlePadding: EdgeInsets.zero,
      content: content,
      scrollable: scrollable??false,
      actionsAlignment: MainAxisAlignment.spaceAround,
      actionsPadding: EdgeInsets.zero,
      actions: 
      hasButtons
      ?
      [
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey[400]!,
                width: 1
              )
            )
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('ANNULLA'),
                ),
                VerticalDivider(width: 1, color: Colors.grey[400]!),
                TextButton(
                  onPressed: onPressedConfirm,
                  child: Text('CONFERMA'),
                ),
              ]
            )
          )
        )
      ]
      : null,
      title: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: TripUtils.purple,
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.abc, color: Colors.transparent),
              Text(title),
              InkWell(
                onTap: () {
                  Get.back();
                }, 
                child: Icon(
                  Icons.close, color: Colors.white
                )
              )
            ],
          )
        ),
      );
    }
  }

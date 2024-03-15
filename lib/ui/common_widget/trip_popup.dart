import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripPopup extends StatelessWidget {
  String title;
  String descriptionText;
  bool hasButton;
  TripPopup({
    super.key,
    required this.title,
    required this.descriptionText,
    this.hasButton = false
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titlePadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.close, color: Colors.transparent),
          Text(title),
          TextButton(
            onPressed: () {
              Get.back();
            }, 
            child: Icon(Icons.close)
          )
        ],
      ),
      
      scrollable: true,
      content: Column(
        children: [
          Text(descriptionText)
        ],
      ),
      actions:
        [
          hasButton 
            ? TextButton(
                onPressed: () {
                }, 
                child: Text('CONFERMA')
              )
            : SizedBox(height: 0, width: 0),
          hasButton
            ? TextButton(
                onPressed: () {
                }, 
                child: Text('CONFERMA')
              )
            : SizedBox(height: 0, width: 0),
        ],
    );
  }
}
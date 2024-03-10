import 'package:flutter/material.dart';
import 'package:tripsync_v3/utils.dart';

class MainButton extends StatelessWidget {
  void Function()? onTap;
  String titleText;
  double fontSize;
  double paddingButton;
  double paddingInterno;
  MainButton({
    super.key,
    required this.onTap,
    required this.titleText,
    this.fontSize = 15,
    this.paddingButton = 10,
    this.paddingInterno = 12.5
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingButton),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(paddingInterno),
          decoration: BoxDecoration(
            color: TripUtils.arancione,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: TripUtils.arancione,
            )
          ),
          width: MediaQuery.of(context).size.width/1,
          child: Text(
            titleText, 
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize, 
              color: Colors.white,
              fontWeight: FontWeight.bold
            )
          )
        )
      ),
    );
  }
}
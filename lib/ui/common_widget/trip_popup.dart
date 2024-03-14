import 'package:flutter/material.dart';

class TripPopup extends StatelessWidget {
  const TripPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text('WAIT.'),
      scrollable: true,
      content: Column(
        children: [
          Text('fratm')
        ],
      ),
    );
  }
}
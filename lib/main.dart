import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tripsync_v3/ui/components/main/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://imsudryomiffczemzekx.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imltc3VkcnlvbWlmZmN6ZW16ZWt4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA0MTgyNDksImV4cCI6MjAxNTk5NDI0OX0.LtxJ3yfF44h4hxP-3vTwHRyyT8wL8Jt4Im-zsZAONF4',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MainPage()
    );
  }
}
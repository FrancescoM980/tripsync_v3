import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TripUtils {
  
  static final supabase = Supabase.instance.client;

  //Palette
  static Color grigioScuro = Color(0xff333a40);
  static Color arancione = Color(0xfff8721b);
  static Color arancioneChiaro = Color(0xffffd099);
  static Color grigioChiaro = Colors.grey[400]!;
  static const Color purple = Color(0xff27002F);
  static const Color purpleChiaro = Color(0xfff8f1f9);

  //LightTheme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: arancione, 
    scaffoldBackgroundColor: grigioScuro,
    colorScheme: ColorScheme.dark(
      primary: arancione, 
      onPrimary: grigioScuro,
      secondary: purple, 
      onSecondary: Colors.white,
      surface: Colors.grey[850]!, 
      onSurface: Colors.white,
    ),
    cardColor: Color(0xff424242),
    appBarTheme: AppBarTheme(
      color: grigioScuro,
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: arancione,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: TextTheme(

    ),
    dividerColor: Colors.white,
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: arancione, 
    scaffoldBackgroundColor: purpleChiaro, 
    colorScheme: ColorScheme.light(
      primary: arancione, 
      onPrimary: Colors.white,
      secondary: arancioneChiaro, 
      onSecondary: grigioScuro, 
      surface: grigioChiaro, 
      onSurface: grigioScuro, 
    ),
    cardColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: purpleChiaro,
      iconTheme: IconThemeData(color: purple),
      titleTextStyle: TextStyle(fontSize: 20, color: purple, fontWeight: FontWeight.bold),
      elevation: 0,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: arancione,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: TextTheme(
      
    ),
    dividerColor: grigioScuro
  );
}
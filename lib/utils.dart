import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TripUtils {
  
  static final supabase = Supabase.instance.client;


  String formatDate(String? dateStr) {
    if (dateStr != null && dateStr.isNotEmpty) {
      DateTime date = DateTime.parse(dateStr);
      var formatCheck = DateFormat('dd MMMM yyyy').format(
        DateTime.parse(dateStr),
      );
      var now = DateFormat('dd MMMM yyyy').format(
        DateTime.now()
      );
      if (now == formatCheck) {
        return 'Oggi';
      } else {
        String formattedDate = '${date.day} ${_getMonthName(date.month)}, ${date.year}';
      return formattedDate;
      }
    } else {
      return 'Undefined';
    }
    
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Gennaio';
      case 2:
        return 'Febbraio';
      case 3:
        return 'Marzo';
      case 4:
        return 'Aprile';
      case 5:
        return 'Maggio';
      case 6:
        return 'Giugno';
      case 7:
        return 'Luglio';
      case 8:
        return 'Agosto';
      case 9:
        return 'Settembre';
      case 10:
        return 'Ottobre';
      case 11:
        return 'Novembre';
      case 12:
        return 'Dicembre';
      default:
        return '';
    }
  }

  //Palette
  static Color grigioScuro = Color(0xff333a40);
  static Color arancione = Color(0xfff8721b);
  static Color arancioneChiaro = Color(0xffffd099);
  static Color grigioChiaro = Colors.grey[400]!;
  static const Color purple = Color(0xff27002F);
  static const Color purpleChiaro = Color(0xfff8f1f9);

  //LightTheme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: purpleChiaro, 
    scaffoldBackgroundColor: grigioScuro,
    colorScheme: ColorScheme.dark(
      primary: arancione, 
      onPrimary: grigioScuro,
      secondary: purple, 
      onSecondary: Colors.white,
      surface: Colors.grey[850]!, 
      onSurface: Colors.white,
    ),
    cardTheme: CardTheme(
      color: grigioScuro,
    ),
    appBarTheme: AppBarTheme(
      color: grigioScuro,
      shadowColor: grigioScuro,
      foregroundColor: grigioScuro,
      surfaceTintColor: grigioScuro,
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: arancione,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: TextTheme(
      labelLarge: TextStyle(
        fontSize: 15
      ),
      labelMedium: TextStyle(
        fontSize: 13
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w300
      )
    ),
    dividerColor: Colors.white,
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: purple, 
    scaffoldBackgroundColor: purpleChiaro, 
    colorScheme: ColorScheme.light(
      primary: arancione, 
      onPrimary: Colors.white,
      secondary: arancioneChiaro, 
      onSecondary: grigioScuro, 
      surface: grigioChiaro, 
      onSurface: grigioScuro, 
    ),
    cardTheme: CardTheme(
      color: Colors.white
    ),
    appBarTheme: AppBarTheme(
      color: purpleChiaro,
      shadowColor: purpleChiaro,
      foregroundColor: purpleChiaro,
      surfaceTintColor: purpleChiaro,
      iconTheme: IconThemeData(color: purple),
      titleTextStyle: TextStyle(fontSize: 20, color: purple, fontWeight: FontWeight.bold),
      elevation: 0,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: arancione,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: TextTheme(
      labelLarge: TextStyle(
        fontSize: 15
      ),
      labelMedium: TextStyle(
        fontSize: 13
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w300
      )
    ),
    dividerColor: grigioScuro
  );
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pnt_dice_game/pages/launcher_page.dart';

class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 66, 65, 65),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        textTheme: GoogleFonts.afacadTextTheme(),
      ),
      home: const LauncherPage(),
    );
  }
}

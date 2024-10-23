import 'package:flutter/material.dart';
import 'package:pnt_dice_game/pages/dice_home_page.dart';

class LauncherPage extends StatefulWidget {
  const LauncherPage({super.key});

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    gotoHomeScreen();
    super.initState();
  }

  void gotoHomeScreen() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const DiceHomePage()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/images/dice_logo.jpg')),
          const CircularProgressIndicator(),
          const SizedBox(
            height: 20,
          ),
          const Text('Version : 1.0.0'),
        ],
      ),
    );
  }
}

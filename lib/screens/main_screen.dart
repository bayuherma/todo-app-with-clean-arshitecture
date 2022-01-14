import 'package:flutter/material.dart';
import 'package:todo/screens/home/home_screen.dart';
import 'package:todo/screens/drawer/drawer_screen.dart';
import 'package:todo/theme.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            DrawerScreen(),
            HomeScreen(),
          ],
        ),
      ),
      
    );
  }
}
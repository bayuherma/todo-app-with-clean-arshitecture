import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    setState(() {
      Timer(Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
    );
  }
}
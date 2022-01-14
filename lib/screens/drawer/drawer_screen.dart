import 'package:flutter/material.dart';
import 'package:todo/screens/home/home_screen.dart';
import 'package:todo/theme.dart';

import 'widgets/menu_item.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      color: kPrimaryColor,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.05,
        left: 24,
        right: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(4),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: kWhiteColor, width: 2),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/user.png',
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    HomeScreen();
                  });
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: kWhiteColor, width: 2),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icons/back.png',
                      color: kWhiteColor,
                      height: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            'John Curl',
            style: kWhiteTextStyle.copyWith(
              fontSize: 30,
              fontWeight: bold,
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children: const[
              MenuItem(),
              MenuItem(),
              MenuItem(),
              MenuItem(),
            ],
          ),
        ],
      ),
    );
  }
}

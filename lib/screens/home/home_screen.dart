import 'package:flutter/material.dart';

import '../../theme.dart';
import 'widgets/card_view.dart';
import 'widgets/list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  double borderLeft = 0;
  double borderBottom = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor),
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: kBackgroundColor,
       borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderLeft),
          bottomLeft: Radius.circular(borderBottom),
        ),
      ),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 104),
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning,\nJohn',
                  style: kBlackTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Categories',
                  style: kGreyTextStyle.copyWith(fontWeight: medium),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: const [
                      CardView(),
                      CardView(),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Today\'s Tasks',
                  style: kGreyTextStyle.copyWith(fontWeight: medium),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 24),
                    child: ListView(
                      children: const [
                        ListItem(),
                        ListItem(),
                        ListItem(),
                        ListItem(),
                        ListItem(),
                        ListItem(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          customAppbar(),
          Positioned(
            right: 24,
            bottom: 24,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: kSecondaryColor,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  Widget customAppbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      height: 80,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderLeft),
          bottomLeft: Radius.circular(borderBottom),
        ),
      ),
      child: Row(
        children: [
          isDrawerOpen
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      xOffset = 0;
                      yOffset = 0;
                      scaleFactor = 1;
                      isDrawerOpen = false;
                      borderLeft = 0;
                      borderBottom = 0;
                    });
                  },
                  child: Image.asset(
                    'assets/icons/back.png',
                    color: kPrimaryColor,
                    height: 24,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      xOffset = MediaQuery.of(context).size.width * 0.7;
                      yOffset = MediaQuery.of(context).size.height * 0.05;
                      scaleFactor = 0.9;
                      isDrawerOpen = true;
                      borderLeft = 24;
                      borderBottom = 24;
                    });
                  },
                  child: Image.asset(
                    'assets/icons/menu.png',
                    color: kPrimaryColor,
                    height: 24,
                  ),
                ),
          const Spacer(),
          Image.asset(
            'assets/icons/search.png',
            color: kPrimaryColor,
            height: 24,
          ),
          const SizedBox(width: 16),
          Image.asset(
            'assets/icons/notif.png',
            color: kPrimaryColor,
            height: 24,
          ),
        ],
      ),
    );
  }
}

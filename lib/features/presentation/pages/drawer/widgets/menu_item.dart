import 'package:flutter/material.dart';

import '../../../../../theme.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/category.png',
            color: kWhiteColor.withOpacity(0.7),
            height: 24,
          ),
          const SizedBox(width: 24),
          Text(
            'Categories',
            style: kWhiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: regular,
            ),
          ),
        ],
      ),
    );
  }
}
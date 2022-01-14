import 'package:flutter/material.dart';

import '../../../theme.dart';

class CardView extends StatelessWidget {
  const CardView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.44,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '6 tasks',
            style: kGreyTextStyle.copyWith(fontWeight: medium),
          ),
          Text(
            'Personal',
            style: kBlackTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 5,
            width: double.infinity,
            color: kBackgroundColor,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo/theme.dart';

void snackBarError({
  required BuildContext context,
  String? msg,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$msg'),
          const Icon(
            Icons.error_outline,
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}

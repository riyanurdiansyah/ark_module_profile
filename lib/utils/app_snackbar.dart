import 'package:flutter/material.dart';
import 'app_style_text.dart';

class AppSnackbar {
  static defaultSnack(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: AppStyleText.styleMontserrat(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        duration: const Duration(
          milliseconds: 500,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../resources/resources.dart';

class Alerts {
  static void showActionSnackBar(
    BuildContext context, {
    required String message,
    required String actionLabel,
    required VoidCallback onActionPressed,
    Duration duration = Time.longTime,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: AppColors.grey,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(AppPadding.p16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s8)),
        action: SnackBarAction(label: actionLabel,onPressed: onActionPressed,textColor: AppColors.white),
        content: Text(message, style: const TextStyle(color: AppColors.white)),
      ),
    );
  }
}

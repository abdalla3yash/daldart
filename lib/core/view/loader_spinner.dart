import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:deldart/core/resources/resources.dart';
import 'package:flutter/material.dart';

Widget loaderSpinner() => const CircularProgressIndicator(strokeWidth: 1.0, color: AppColors.primary);

Widget postLoader(context) => Container(
      padding: const EdgeInsets.all(AppPadding.p8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s4),color: AppColors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: AppSize.s12,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s28),color: AppColors.lightGrey)).applyShimmer(),
          const SizedBox(height: AppPadding.p8),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: AppSize.s12,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s28),color: AppColors.lightGrey)).applyShimmer(),
          const SizedBox(height: AppPadding.p2),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: AppSize.s12,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s28),color: AppColors.lightGrey)).applyShimmer(),
          const SizedBox(height: AppPadding.p4),
        ],
      ),
    );

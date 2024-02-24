// ignore_for_file: must_be_immutable

import 'package:deldart/core/resources/app_colors.dart';
import 'package:deldart/core/resources/app_values.dart';
import 'package:deldart/core/utils/contact_helper.dart';
import 'package:deldart/features/home/model/riddit_post_model.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  RidditPostsModel redditPost;
   PostItem({super.key,required this.redditPost});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> ContactHelper.launchURL(redditPost.ridditPostsDataModel!.permalink!),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s4), color: AppColors.white, border: const Border(top: BorderSide(color: AppColors.borderColor, width: AppPadding.p4))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(redditPost.ridditPostsDataModel!.title ??'', style: Theme.of(context).textTheme.labelLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: AppPadding.p4),
            Text(redditPost.ridditPostsDataModel!.selftext ?? '', maxLines: 3, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: AppPadding.p4),
            
          ],
        ),
      ),
    );
  }
}

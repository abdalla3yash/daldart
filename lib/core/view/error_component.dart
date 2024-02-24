import 'package:deldart/core/resources/resources.dart';
import 'package:flutter/material.dart';

class ErrorComponent extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorComponent({required this.message, required this.onRetry, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_sharp,color: AppColors.red,size: 128),
            const SizedBox(height: AppSize.s16),
            Text(message,textAlign: TextAlign.center),
            const SizedBox(height: AppSize.s16),
            GestureDetector(onTap: onRetry,child: Container(width: MediaQuery.of(context).size.width * 0.4,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSize.s12),color: AppColors.red),child:const Center(child: Text('Retry',style: TextStyle(color: AppColors.white)),))),
          ],
        ),
      ),
    );
  }
}

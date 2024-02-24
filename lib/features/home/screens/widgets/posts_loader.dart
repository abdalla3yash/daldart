import 'package:deldart/core/resources/resources.dart';
import 'package:deldart/core/view/loader_spinner.dart';
import 'package:flutter/material.dart';

class PostsLoader extends StatelessWidget {
  const PostsLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: ListView.separated(
              itemBuilder: (context, index) => postLoader(context),
              separatorBuilder: (context, index) => SizedBox.fromSize(size: const Size.fromHeight(AppPadding.p12)),
              itemCount: 10,
            ),
          ),
        ),
      ],
    );
  }
}

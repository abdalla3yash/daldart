import 'package:deldart/core/enums/home_request_state.dart';
import 'package:deldart/core/enums/http_request_state.dart';
import 'package:deldart/core/resources/app_values.dart';
import 'package:deldart/core/utils/alerts.dart';
import 'package:deldart/core/view/loader_spinner.dart';
import 'package:deldart/features/home/cubit/home_cubit.dart';
import 'package:deldart/features/home/screens/widgets/post_item.dart';
import 'package:deldart/features/home/screens/widgets/posts_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RisingView extends StatefulWidget {
  const RisingView({super.key});
  @override
  State<RisingView> createState() => _RisingViewState();
}

class _RisingViewState extends State<RisingView> {
    final scrollController = ScrollController();

 void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge && scrollController.position.pixels != 0) {
        BlocProvider.of<HomeCubit>(context).getRisingPosts();
      }
    });
  }
 @override
  void initState() {
    if(context.read<HomeCubit>().state.risingRedditPosts == null ) context.read<HomeCubit>().getRisingPosts();
    setupScrollController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<HomeCubit, HomeState>(
        listenWhen: (prevState, state) => state.homeRequestType == HomeRequestType.getRisingPosts,
        listener: (context, state) {
          if (state.httpRequestState == HttpRequestState.failure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Alerts.showActionSnackBar(context,
                message: state.failure!.message,
                actionLabel: 'Retry',
                onActionPressed: () => context.read<HomeCubit>().getRisingPosts());
            });
          }
        },
        buildWhen: (previous, state) => state.homeRequestType == HomeRequestType.getRisingPosts,
        builder: (context, state) => state.httpRequestState == HttpRequestState.success || state.httpRequestState == HttpRequestState.fetch
          ? Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: ListView.separated(
                    controller: scrollController,
                    itemBuilder: (context, index) => PostItem(redditPost: state.risingRedditPosts![index]),
                    separatorBuilder: (context, index) => SizedBox.fromSize(size: const Size.fromHeight(AppPadding.p12)),
                    itemCount: state.risingRedditPosts!.length,
                  ),
                ),
              ),
              const SizedBox(height: AppPadding.p24),
              state.httpRequestState == HttpRequestState.fetch ? Padding(padding: const EdgeInsets.all(AppPadding.p8), child:   loaderSpinner()) :const SizedBox(),
            ],
          ) : const PostsLoader()
        ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deldart/core/enums/home_request_state.dart';
import 'package:deldart/core/enums/http_request_state.dart';
import 'package:deldart/core/resources/resources.dart';
import 'package:deldart/core/services/firebase/firebse_constant.dart';
import 'package:deldart/core/utils/alerts.dart';
import 'package:deldart/core/view/error_component.dart';
import 'package:deldart/core/view/loader_spinner.dart';
import 'package:deldart/features/home/cubit/home_cubit.dart';
import 'package:deldart/features/home/model/firebase_post_model.dart';
import 'package:deldart/features/home/screens/widgets/post_item_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class HotView extends StatefulWidget {
  const HotView({super.key});
  @override
  State<HotView> createState() => _HotViewState();
}

class _HotViewState extends State<HotView> {
  final scrollController = ScrollController();
  late String afterSlug;

  @override
  void initState() {
    setupScrollController(context);
    super.initState();
  }

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge && scrollController.position.pixels != 0) {
        BlocProvider.of<HomeCubit>(context).getHotPosts(afterSlug: afterSlug);
      }
    });
  }

  Stream<Map<String, Object>> getPostsStream() {
  return FirebaseFirestore.instance.collection(FireBaseConstants.postCollection).doc(FireBaseConstants.hotDocument).snapshots().switchMap((afterSnapshot) {
    final afterSlug = afterSnapshot.data()?[FireBaseConstants.afterFieldDocument] as String? ?? '';
    return FirebaseFirestore.instance.collection(FireBaseConstants.postCollection).doc(FireBaseConstants.hotDocument).collection(FireBaseConstants.postCollection).snapshots()
      .map((snapshot) {
        final List<FirebasePost> postsData = snapshot.docs.map((doc) => FirebasePost.fromMap(doc.data())).toList();
        return {FireBaseConstants.afterFieldDocument: afterSlug, FireBaseConstants.postCollection: postsData};
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()=> BlocProvider.of<HomeCubit>(context).getHotPosts(afterSlug: ''),
      child: SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
          listenWhen: (prevState, state) => state.homeRequestType == HomeRequestType.getHotPosts,
          listener: (context, state) {
            if (state.httpRequestState == HttpRequestState.failure) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Alerts.showActionSnackBar(context,
                    message: state.failure!.message,
                    actionLabel: 'Retry',
                    onActionPressed: () => context.read<HomeCubit>().getHotPosts(afterSlug: afterSlug));
              });
            }
          },
          buildWhen: (previous, state) => state.homeRequestType == HomeRequestType.getHotPosts,
          builder: (context, state) => Column(children: [
            Expanded(
              child: StreamBuilder<Map<String, Object>>(
              stream: getPostsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return ErrorComponent(
                    message: snapshot.error.toString(),
                    onRetry: () => context.read<HomeCubit>().getHotPosts(afterSlug: afterSlug)
                  );
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: ListView.separated(
                    controller: scrollController,
                    itemBuilder: (context, index) =>postLoader(context),
                    separatorBuilder: (context, index) => SizedBox.fromSize(size: const Size.fromHeight(AppPadding.p12)),
                    itemCount: 10,
                    ),
                  );
                }
                final Map<String, dynamic> data = snapshot.data!;
                afterSlug = data[FireBaseConstants.afterFieldDocument];
                final List<FirebasePost> postsData = data[FireBaseConstants.postCollection];
                return Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: ListView.separated(
                    controller: scrollController,
                    itemBuilder: (context, index) => PostItemFromFirebase(firebasePost: postsData[index]),
                    separatorBuilder: (context, index) => SizedBox.fromSize(size: const Size.fromHeight(AppPadding.p12)),
                    itemCount: postsData.length),
                  );
                },
              )
            ),
            const SizedBox(height: AppPadding.p24),
            state.httpRequestState == HttpRequestState.loading ? Padding( padding: const EdgeInsets.all(AppPadding.p8), child: loaderSpinner()): const SizedBox(),
          ]),
        ),
      ),
    );
  }
}

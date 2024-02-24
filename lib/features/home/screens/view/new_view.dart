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

class NewView extends StatefulWidget {
  const NewView({super.key});
  @override
  State<NewView> createState() => _NewViewState();
}

class _NewViewState extends State<NewView> {
  final scrollController = ScrollController();
    late String afterSlug;

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge && scrollController.position.pixels != 0) {
        BlocProvider.of<HomeCubit>(context).getNewPosts(afterSlug: afterSlug);
      }
    });
  }

  @override
  void initState() {
    setupScrollController(context);
    super.initState();
  }

  Future<String> getAfterSlug() async {
  final afterSnapshot = await FirebaseFirestore.instance.collection(FireBaseConstants.postCollection).doc(FireBaseConstants.newDocument).get();
  final afterSlug = afterSnapshot.data()?[FireBaseConstants.afterFieldDocument] as String? ?? '';
  return afterSlug;
  }

  Future<List<FirebasePost>> getPostsData() async {
    final snapshot = await FirebaseFirestore.instance.collection(FireBaseConstants.postCollection).doc(FireBaseConstants.newDocument).collection(FireBaseConstants.postCollection).get();
    final List<FirebasePost> postsData = snapshot.docs.map((doc) => FirebasePost.fromMap(doc.data())).toList();
    return postsData;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()=> BlocProvider.of<HomeCubit>(context).getNewPosts(afterSlug: ''),
      child: SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
          listenWhen: (prevState, state) => state.homeRequestType == HomeRequestType.getNewPosts,
          listener: (context, state) {
            if (state.httpRequestState == HttpRequestState.failure) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Alerts.showActionSnackBar(context,
                  message: state.failure!.message,
                  actionLabel: 'Retry',
                  onActionPressed: () => context.read<HomeCubit>().getNewPosts(afterSlug: afterSlug));
              });
            }
          },
          buildWhen: (previous, state) => state.homeRequestType == HomeRequestType.getNewPosts,
          builder: (context, state) =>  Column(
            children: [
              Expanded(
                child: FutureBuilder<List<Object>>(
                future:  Future.wait([getAfterSlug(), getPostsData()]),
                builder: (context, snapshot) {
      
                if (snapshot.hasError) {
                  return ErrorComponent(
                    message: "something went wrong, please try again!",
                    onRetry: () => context.read<HomeCubit>().getNewPosts(afterSlug: afterSlug)
                  );
                }
      
                if (!snapshot.hasData|| snapshot.data == null) {
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
                  final List<dynamic> results = snapshot.data as List<dynamic>;
                  afterSlug = results[0] as String;
                  final List<FirebasePost> postsData = results[1] as List<FirebasePost>;
                  return snapshot.hasData ?  
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: ListView.separated(
                      controller: scrollController,
                      itemBuilder: (context, index) => PostItemFromFirebase(firebasePost: postsData[index]),
                      separatorBuilder: (context, index) => SizedBox.fromSize(size: const Size.fromHeight(AppPadding.p12)),
                      itemCount: postsData.length,
                    ),
                  )
                  : Center(child: loaderSpinner());
                },
                )
              ),
              const SizedBox(height: AppPadding.p24),
              state.httpRequestState == HttpRequestState.loading ?  Padding(padding: const EdgeInsets.all(AppPadding.p8), child: loaderSpinner()) :const SizedBox(),
            ],
          ) 
        ),
      ),
    );
  }
}

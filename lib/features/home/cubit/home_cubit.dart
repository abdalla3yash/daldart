import 'package:deldart/core/enums/home_request_state.dart';
import 'package:deldart/core/services/firebase/firebase_service.dart';
import 'package:deldart/core/services/firebase/firebse_constant.dart';
import 'package:deldart/core/services/network/endpoints.dart';
import 'package:deldart/features/home/model/riddit_post_model.dart';
import 'package:deldart/features/home/model/firebase_post_model.dart';
import 'package:deldart/features/home/repositories/home_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/enums/http_request_state.dart';
import '../../../../core/services/error/failure.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;
  final FirebaseService _firebaseService;

  HomeCubit(this._homeRepository,this._firebaseService) : super(HomeState());

  Future<void> getNewPosts({String? afterSlug}) async {   
    emit(state.copyWith(httpRequestState: HttpRequestState.loading , homeRequestType: HomeRequestType.getNewPosts));
    final result = await _homeRepository.getposts(endPoint: EndPoints.newEndPoint,afterSlug: afterSlug!);
    result.fold(
      (failure) => emit(state.copyWith(failure: failure, httpRequestState: HttpRequestState.failure, homeRequestType: HomeRequestType.getNewPosts)),
      (data) async {
        final List<RidditPostsModel> posts = List<RidditPostsModel>.from(data.ridditDataModel!.children!.map((post) => RidditPostsModel.fromJson(post.toJson())));
        for (var post in posts) {
          FirebasePost firebasePost = FirebasePost(documentId: post.ridditPostsDataModel!.id!,  subreddit: post.ridditPostsDataModel!.subreddit ?? "", title: post.ridditPostsDataModel!.title ??" ", selfText: post.ridditPostsDataModel!.selftext ?? "", permalink: post.ridditPostsDataModel!.permalink.toString());
          await _firebaseService.updatePostData(data:firebasePost.toMap(),collectionReference: FireBaseConstants.newDocument,afterSlug: {FireBaseConstants.afterFieldDocument:data.ridditDataModel!.after.toString()});
        }
        emit(state.copyWith(httpRequestState: HttpRequestState.success, homeRequestType: HomeRequestType.getNewPosts));
      },
    );
  }


  Future<void> getHotPosts({String? afterSlug}) async {
    emit(state.copyWith(httpRequestState: HttpRequestState.loading, homeRequestType: HomeRequestType.getHotPosts));
    final result = await _homeRepository.getposts(endPoint: EndPoints.hotEndPoint,afterSlug:afterSlug!);
    result.fold(
      (failure) => emit(state.copyWith(failure: failure, httpRequestState: HttpRequestState.failure, homeRequestType: HomeRequestType.getHotPosts)),
      (data) async {
        final List<RidditPostsModel> posts = List<RidditPostsModel>.from(data.ridditDataModel!.children!.map((post) => RidditPostsModel.fromJson(post.toJson())));
        for (var post in posts) {
          FirebasePost firebasePost = FirebasePost(documentId: post.ridditPostsDataModel!.id!, subreddit: post.ridditPostsDataModel!.subreddit ?? "", title: post.ridditPostsDataModel!.title ?? "", selfText: post.ridditPostsDataModel!.selftext ?? "", permalink: post.ridditPostsDataModel!.permalink.toString());
          await _firebaseService.updatePostData(data:firebasePost.toMap(),collectionReference: FireBaseConstants.hotDocument,afterSlug: {FireBaseConstants.afterFieldDocument:data.ridditDataModel!.after.toString()});
        }
        emit(state.copyWith(httpRequestState: HttpRequestState.success, homeRequestType: HomeRequestType.getHotPosts));
      },
    );
  }


  Future<void> getRisingPosts() async {

    if (state.httpRequestState == HttpRequestState.fetch && state.homeRequestType == HomeRequestType.getRisingPosts) return;
    List<RidditPostsModel> allPosts = [];
    if (state.httpRequestState == HttpRequestState.success && state.homeRequestType == HomeRequestType.getRisingPosts) allPosts = state.risingRedditPosts!;

    emit(state.copyWith(httpRequestState: state.risingRedditPosts == null ? HttpRequestState.loading :HttpRequestState.fetch , homeRequestType: HomeRequestType.getRisingPosts));
    final result = await _homeRepository.getposts(endPoint: EndPoints.risingEndPoint,afterSlug: state.risingRedditPosts == null ? '' : state.afterSlug);
    result.fold(
      (failure) => emit(state.copyWith(failure: failure, httpRequestState: HttpRequestState.failure,homeRequestType: HomeRequestType.getRisingPosts)),
      (data) async {
        final List<RidditPostsModel> posts = List<RidditPostsModel>.from(data.ridditDataModel!.children!.map((post) => RidditPostsModel.fromJson(post.toJson())));
        state.afterSlug = data.ridditDataModel!.after.toString();
        allPosts.addAll(posts); 
        emit(state.copyWith(risingRedditPosts: allPosts, httpRequestState: HttpRequestState.success, homeRequestType: HomeRequestType.getRisingPosts));
        for (var post in posts) {
          FirebasePost firebasePost = FirebasePost(
            documentId: post.ridditPostsDataModel!.id.toString(), 
            subreddit: post.ridditPostsDataModel!.subreddit??"",
            title: post.ridditPostsDataModel!.title??"",
            selfText: post.ridditPostsDataModel!.selftext??"",
            permalink: post.ridditPostsDataModel!.permalink.toString(),
          );
          await _firebaseService.updatePostData(data:firebasePost.toMap(),collectionReference: FireBaseConstants.risingDocument,afterSlug: {FireBaseConstants.afterFieldDocument:data.ridditDataModel!.after.toString()});
        }
      },
    );
  }
}

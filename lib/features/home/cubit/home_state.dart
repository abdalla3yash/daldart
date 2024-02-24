part of 'home_cubit.dart';

class HomeState {
  final HttpRequestState httpRequestState;
  final Failure? failure;
  final List<RidditPostsModel>? risingRedditPosts;
  final List<RidditPostsModel>? oldRedditPosts;
  final HomeRequestType? homeRequestType;
  String afterSlug;

  HomeState({
    this.httpRequestState = HttpRequestState.none,
    this.failure,
    this.risingRedditPosts,
    this.homeRequestType = HomeRequestType.none,
    this.oldRedditPosts,
    this.afterSlug = '',
  });

  HomeState copyWith({
    HttpRequestState? httpRequestState,
    Failure? failure,
    List<RidditPostsModel>? risingRedditPosts,
    HomeRequestType? homeRequestType,
    List<RidditPostsModel>? oldRedditPosts,
    String? afterSlug,
  }) =>
      HomeState(
          httpRequestState: httpRequestState ?? this.httpRequestState,
          failure: failure,
          risingRedditPosts: risingRedditPosts ?? this.risingRedditPosts,
          homeRequestType: homeRequestType ?? this.homeRequestType,
          oldRedditPosts: oldRedditPosts ?? this.oldRedditPosts,
          afterSlug: afterSlug ?? this.afterSlug);
}

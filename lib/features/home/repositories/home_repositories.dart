import 'package:dartz/dartz.dart';
import 'package:deldart/core/base/repositories/base_repository.dart';
import 'package:deldart/core/services/error/failure.dart';
import 'package:deldart/core/services/network/api_client.dart';
import 'package:deldart/features/home/model/reddit_model.dart';

class HomeRepository extends BaseRepository {
  final ApiClient _apiClient;

  HomeRepository(this._apiClient, super.networkInfo);

  Future<Either<Failure, RedditListingModel>> getposts({required String endPoint,required String afterSlug}) async {
    return super.call<RedditListingModel>(
      httpRequest: () => _apiClient.get(url: endPoint, queryParameters: {"limit": 10,"after":afterSlug}),
      successReturn: (data) => data
    );
  }

}

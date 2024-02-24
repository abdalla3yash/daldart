import 'package:dartz/dartz.dart';
import 'package:deldart/features/home/model/reddit_model.dart';
import 'package:dio/dio.dart';
import '../../services/error/error_handler.dart';
import '../../services/error/failure.dart';
import '../../services/network/network_info.dart';

abstract class BaseRepository {
  final NetworkInfo networkInfo;
  BaseRepository(this.networkInfo);

  Future<Either<Failure, R>> call<R>(
    {required Future<Response<dynamic>> Function() httpRequest, required R Function(dynamic data) successReturn}) async {
      
    final bool hasConnection = await networkInfo.hasConnection;
    if (hasConnection) {
      try {
        final response = await httpRequest();
        final data = successReturn(RedditListingModel.fromJson(response.data));
        return Right(data);
      } on Exception catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(ErrorType.noInternetConnection.getFailure());
    }
  }
}

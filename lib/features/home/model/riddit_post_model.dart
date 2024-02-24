import 'riddit_post_data_model.dart';

class RidditPostsModel {
  String? kind;
  RidditPostsDataModel? ridditPostsDataModel;

  RidditPostsModel({this.kind, this.ridditPostsDataModel});

  RidditPostsModel.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    ridditPostsDataModel = json['data'] != null ? RidditPostsDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    if (ridditPostsDataModel != null) {
      data['data'] = ridditPostsDataModel!.toJson();
    }
    return data;
  }
}

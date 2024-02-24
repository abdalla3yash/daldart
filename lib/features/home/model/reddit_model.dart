import 'package:deldart/features/home/model/riddit_data_model.dart';

class RedditListingModel {
  String? kind;
  RidditDataModel? ridditDataModel;

  RedditListingModel({this.kind, this.ridditDataModel});

  RedditListingModel.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    ridditDataModel = json['data'] != null ? RidditDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kind'] = kind;
    if (ridditDataModel != null) {
      data['data'] = ridditDataModel!.toJson();
    }
    return data;
  }
}

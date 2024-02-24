import 'riddit_post_model.dart';

class RidditDataModel {
  String? after;
  int? dist;
  String? modhash;
  String? geoFilter;
  List<RidditPostsModel>? children;
  String? before;

  RidditDataModel(
      {this.after,
      this.dist,
      this.modhash,
      this.geoFilter,
      this.children,
      this.before});

  RidditDataModel.fromJson(Map<String, dynamic> json) {
    after = json['after'];
    dist = json['dist'];
    modhash = json['modhash'];
    geoFilter = json['geo_filter'];
    if (json['children'] != null) {
      children = <RidditPostsModel>[];
      json['children'].forEach((v) {
        children!.add(RidditPostsModel.fromJson(v));
      });
    }
    before = json['before'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['after'] = after;
    data['dist'] = dist;
    data['modhash'] = modhash;
    data['geo_filter'] = geoFilter;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    data['before'] = before;
    return data;
  }
}

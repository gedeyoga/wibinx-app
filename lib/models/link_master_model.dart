import 'package:equatable/equatable.dart';

class LinkMasterModel extends Equatable {

  final int? id;
  final String? link_name;
  final String? main_url;
  final String? slug_link;
  final String? icon_name;

  LinkMasterModel({
    this.id,
    this.link_name,
    this.main_url = '',
    this.slug_link = '',
    this.icon_name = '',
  });

  @override
  List<Object?> get props => [id, link_name, main_url, slug_link, icon_name];

  factory LinkMasterModel.fromJson(dynamic json) {
    return LinkMasterModel(
      id: json["id"],
      link_name: json["link_name"],
      main_url: json["main_url"],
      slug_link: json["slug_link"],
      icon_name: json["icon_name"]
    );
  }

}
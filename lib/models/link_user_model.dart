import 'package:equatable/equatable.dart';

class LinkUserModel extends Equatable {

  final int? id;
  final int? website_user_id;
  final int? link_master_id;
  final String name;
  final String url;
  final String custom_icon;
  final List website;
  final List link_master;

  LinkUserModel({
    this.id,
    this.website_user_id,
    this.link_master_id,
    this.name = '',
    this.url = '',
    this.custom_icon = '',
    this.website = const [],
    this.link_master = const [],
  });

  @override
  List<Object?> get props => [id, website_user_id, link_master_id, name, url, custom_icon , website, link_master
      ];

  factory LinkUserModel.fromJson(Map<String, dynamic> json) {
    return LinkUserModel(
      id: json["id"],
      website_user_id: json["website_user_id"],
      link_master_id: json["link_master_id"],
      name: json["name"] ?? "",
      url: json["url"] ?? "",
      custom_icon: json["custom_icon"] ?? "",
      website: json["website"],
      link_master: json["link_master"],
    );
  }

}
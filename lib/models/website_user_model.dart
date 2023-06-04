import 'package:equatable/equatable.dart';

class WebsiteUserModel extends Equatable {

  final int? id;
  final int? user_id;
  final theme_id;
  final String name;
  final String description;
  final String link_name;

  WebsiteUserModel({
    this.id,
    this.name = '',
    this.user_id,
    this.theme_id,
    this.description = '',
    this.link_name = '',
  });

  @override
  List<Object?> get props => [id, name,user_id,theme_id, description, link_name];

  factory WebsiteUserModel.fromJson(Map<String, dynamic> json) {
    return WebsiteUserModel(
      id: json["id"],
      name: json["name"] ?? "",
      user_id: json["email"],
      theme_id: json["roles"],
      description: json["description"] ?? "",
      link_name: json["link_name"] ?? "",
    );
  }

}
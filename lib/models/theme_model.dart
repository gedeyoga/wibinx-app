import 'package:equatable/equatable.dart';

class ThemeModel extends Equatable {

  final int id;
  final String name;
  final String slug;
  final String type;
  final String status;
  final bool default_theme;
  final Map<String,dynamic> thumbnail_file;

  ThemeModel({
    this.id = 0,
    this.name = '',
    this.slug = '',
    this.type = '',
    this.status = '',
    this.default_theme = false,
    required this.thumbnail_file,
  });

  @override
  List<Object?> get props => [id, name, slug, type, status , default_theme , thumbnail_file];

  factory ThemeModel.fromJson(dynamic json) {
    return ThemeModel(
      id: json["id"],
      name: json["name"],
      slug: json["slug"],
      type: json["type"],
      status: json["status"],
      default_theme: json["default"],
      thumbnail_file: json["thumbnail_file"],
    );
  }

}
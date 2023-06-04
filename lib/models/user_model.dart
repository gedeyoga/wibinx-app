import 'package:equatable/equatable.dart';

class UserModel extends Equatable {

  final int? id;
  final String name;
  final String email;
  final List? roles;
  final List? websites;

  UserModel({
    this.id,
    this.name = '',
    this.email = '',
    this.roles = const [],
    this.websites = const [],
  });

  @override
  List<Object?> get props => [id, name,email,roles, websites];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      roles: json["roles"] ?? [],
      websites: json["websites"] ?? [],
    );
  }

}
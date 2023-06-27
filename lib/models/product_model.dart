import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {

  final int? id;
  final String name;
  final String description;
  final int harga;
  final int section_id;
  final String link_product;

  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.harga,
    required this.section_id,
    required this.link_product,
  });

  @override
  List<Object?> get props => [id, name,description,harga, section_id, link_product];

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      harga: json["harga"],
      section_id: json["section_id"],
      link_product: json["link_product"],
    );
  }

}
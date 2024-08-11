import 'package:flutter/material.dart';


class Garagepost {
  final int id;
  final String name;
  final String description;
  final String image;
  final int garageId;
  final int createByUserId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Garagepost({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.garageId,
    required this.createByUserId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Garagepost.fromJson(Map<String, dynamic> json) {
    return Garagepost(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      garageId: json['garage_id'],
      createByUserId: json['create_by_user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

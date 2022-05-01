import 'package:flutter_lesson_9/models/address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';

@JsonSerializable(explicitToJson: true)
class Info {
  final String uuid;
  final String name;
  final String poster;
  final Address address;
  final double price;
  final double rating;
  final Map<String, List<String>> services;
  final List<String> photos;

  Info(this.uuid, this.name, this.poster, this.address, this.price, this.rating,
      this.services, this.photos);
  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

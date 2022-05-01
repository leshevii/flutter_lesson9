import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  final String country;
  final String street;
  final String city;
  final int zip_code;
  final Map<String, double> coords;

  Address(this.country, this.street, this.city, this.zip_code, this.coords);
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

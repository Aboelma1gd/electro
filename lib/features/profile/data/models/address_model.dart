import 'package:electro/features/checkout/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel(
      {required super.address,
      required super.city,
      required super.state,
      required super.zipCode,
      required super.name,
      required super.mobileNumber});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zipCode'],
      name: json['name'],
      mobileNumber: json['mobileNumber'],
    );
  }

  Map<String, dynamic> toJson() => {
        'address': address,
        'city': city,
        'state': state,
        'zipCode': zipCode,
        'name': name,
        'mobileNumber': mobileNumber,
      };
}

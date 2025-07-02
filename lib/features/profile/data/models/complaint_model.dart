import 'package:electro/features/profile/domain/entities/complaint_entity.dart';

class ComplaintModel extends ComplaintEntity{
  ComplaintModel({required super.id, required super.description, required super.userEmail});

  toJson(){
    return {
      'id': id,
      'description': description,
      'userEmail': userEmail,
    };
  }

}
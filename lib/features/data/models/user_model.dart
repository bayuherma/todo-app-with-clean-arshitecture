import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    final String? name,
    final String? email,
    final String? uid,
    final String? status,
    final String? password,
  }) : super(
          uid: uid,
          name: name,
          email: email,
          password: password,
          status: status,
        );

  factory UserModel.fromScapshot(DocumentSnapshot documentSnapshot) {
    return UserModel(
      status: documentSnapshot.get('status'),
      name: documentSnapshot.get('name'),
      uid: documentSnapshot.get('uid'),
      email: documentSnapshot.get('email'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'name' : name,
      'email' : email,
      'uid' : uid,
      'status' : status,
    };
  }
}

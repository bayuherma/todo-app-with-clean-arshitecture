
import 'package:todo/features/domain/entities/user_entity.dart';
import 'package:todo/features/domain/repositories/firebase_repository.dart';

class GetUserUseCase {
  final FirebaseRepository repository;

  GetUserUseCase({required this.repository});

  Future<UserEntity> call(UserEntity user)async {
    return repository.getUser(user);
  }
}
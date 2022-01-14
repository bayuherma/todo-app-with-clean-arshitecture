import 'package:todo/features/domain/entities/todo_entity.dart';
import 'package:todo/features/domain/entities/user_entity.dart';
import 'package:todo/features/domain/repositories/firebase_repository.dart';

class GetCreateCurrentUserUseCase {
  final FirebaseRepository repository;

  GetCreateCurrentUserUseCase({required this.repository});

  Future<void> call(UserEntity user)async {
    return repository.getCreateCurrentUser(user);
  }
}
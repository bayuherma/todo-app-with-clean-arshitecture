
import 'package:todo/features/domain/entities/todo_entity.dart';
import 'package:todo/features/domain/repositories/firebase_repository.dart';

class GetTodosUserCase {
  final FirebaseRepository repository;

  GetTodosUserCase({required this.repository});

  Stream<List<TodoEntity>> call(String uid) {
    return repository.getTodos(uid);
  }
}
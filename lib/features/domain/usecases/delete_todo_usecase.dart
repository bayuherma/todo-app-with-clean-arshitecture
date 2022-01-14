import 'package:todo/features/domain/entities/todo_entity.dart';
import 'package:todo/features/domain/repositories/firebase_repository.dart';

class DeleteTodoUseCase {
  final FirebaseRepository repository;

  DeleteTodoUseCase({required this.repository});

  Future<void> call(TodoEntity todo)async {
    return repository.deleteTodo(todo);
  }
}
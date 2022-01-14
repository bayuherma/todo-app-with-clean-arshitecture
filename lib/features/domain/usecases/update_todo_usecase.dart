import 'package:todo/features/domain/entities/todo_entity.dart';
import 'package:todo/features/domain/repositories/firebase_repository.dart';

class UpdateTodoUseCase {
  final FirebaseRepository repository;

  UpdateTodoUseCase({required this.repository});

  Future<void> call(TodoEntity todo)async {
    return repository.updateTodo(todo);
  }
}
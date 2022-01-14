import 'package:todo/features/domain/entities/todo_entity.dart';
import 'package:todo/features/domain/repositories/firebase_repository.dart';

class AddNewTodoUseCase {
  final FirebaseRepository repository;

  AddNewTodoUseCase({required this.repository});

  Future<void> call(TodoEntity todo)async {
    return repository.addNewTodo(todo);
  }
}
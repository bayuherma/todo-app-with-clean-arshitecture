import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/features/domain/entities/todo_entity.dart';
import 'package:todo/features/domain/usecases/add_new_todo_usecase.dart';
import 'package:todo/features/domain/usecases/delete_todo_usecase.dart';
import 'package:todo/features/domain/usecases/get_todos_usecase.dart';
import 'package:todo/features/domain/usecases/update_todo_usecase.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodoUseCase;
  final GetTodosUserCase getTodosUserCase;
  final AddNewTodoUseCase addNewTodoUseCase;

  TodoCubit({
    required this.updateTodoUseCase,
    required this.deleteTodoUseCase,
    required this.getTodosUserCase,
    required this.addNewTodoUseCase,
  }) : super(TodoInitial());

  Future<void> addNewTodo({required TodoEntity todo}) async {
    try {
      addNewTodoUseCase.call(todo);
    } on SocketException catch (_) {
      emit(TodoFailure());
    } catch (_) {
      emit(TodoFailure());
    }
  }

  Future<void> deleteTodo({required TodoEntity todo}) async {
    try {
      deleteTodoUseCase.call(todo);
    } on SocketException catch (_) {
      emit(TodoFailure());
    } catch (_) {
      emit(TodoFailure());
    }
  }

  Future<void> updateTodo({required TodoEntity todo}) async {
    try {
      updateTodoUseCase.call(todo);
    } on SocketException catch (_) {
      emit(TodoFailure());
    } catch (_) {
      emit(TodoFailure());
    }
  }

  Future<void> getTodos({required String uid}) async {
    emit(TodoLoading());
    try {
      getTodosUserCase.call(uid).listen((todos) {
        emit(TodoLoaded(todos));
      });
    } on SocketException catch (_) {
      emit(TodoFailure());
    } catch (_) {
      emit(TodoFailure());
    }
  }
}

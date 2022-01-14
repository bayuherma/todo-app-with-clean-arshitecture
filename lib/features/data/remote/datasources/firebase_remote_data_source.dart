

import 'package:todo/features/domain/entities/todo_entity.dart';
import 'package:todo/features/domain/entities/user_entity.dart';

abstract class FirebaseRemoteDataSource{
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
  Future<String> getCurrentUId();
  Future<void> getCreateCurrentUser(UserEntity user);
  Future<UserEntity> getUser(UserEntity user);
  Future<void> addNewTodo(TodoEntity todo);
  Future<void> updateTodo(TodoEntity todo);
  Future<void> deleteTodo(TodoEntity todo);
  Stream<List<TodoEntity>> getTodos(String uid);
}
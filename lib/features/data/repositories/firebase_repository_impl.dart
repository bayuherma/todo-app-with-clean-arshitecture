import 'package:todo/features/data/remote/datasources/firebase_remote_data_source.dart';
import 'package:todo/features/domain/entities/user_entity.dart';
import 'package:todo/features/domain/entities/todo_entity.dart';
import 'package:todo/features/domain/repositories/firebase_repository.dart';

class FirebaseRepositoryImpl extends FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addNewTodo(TodoEntity todo) async =>
      remoteDataSource.addNewTodo(todo);

  @override
  Future<void> deleteTodo(TodoEntity todo) async =>
      remoteDataSource.deleteTodo(todo);

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async =>
      remoteDataSource.getCreateCurrentUser(user);

  @override
  Future<String> getCurrentUId() async => remoteDataSource.getCurrentUId();

  @override
  Stream<List<TodoEntity>> getTodos(String uid) =>
      remoteDataSource.getTodos(uid);

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> signIn(UserEntity user) async => remoteDataSource.signIn(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUp(UserEntity user) async => remoteDataSource.signUp(user);

  @override
  Future<void> updateTodo(TodoEntity todo) async =>
      remoteDataSource.updateTodo(todo);

  @override
  Future<UserEntity> getUser(UserEntity user) => remoteDataSource.getUser(user);
}

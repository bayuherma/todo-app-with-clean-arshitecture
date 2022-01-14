import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/features/data/models/todo_model.dart';
import 'package:todo/features/data/models/user_model.dart';
import 'package:todo/features/data/remote/datasources/firebase_remote_data_source.dart';
import 'package:todo/features/domain/entities/user_entity.dart';
import 'package:todo/features/domain/entities/todo_entity.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseRemoteDataSourceImpl({required this.auth, required this.firestore});

  @override
  Future<void> addNewTodo(TodoEntity todoEntity) async {
    final todoCollectionRef =
        firestore.collection('users').doc(todoEntity.uid).collection('todos');

    final todoId = todoCollectionRef.doc().id;

    todoCollectionRef.doc(todoId).get().then((todo) {
      final newTodo = TodoModel(
        uid: todoEntity.uid,
        todoId: todoId,
        todo: todoEntity.todo,
        time: todoEntity.time,
      ).toDocument();

      if (!todo.exists) {
        todoCollectionRef.doc(todoId).set(newTodo);
      }
      return;
    });
  }

  @override
  Future<void> deleteTodo(TodoEntity todoEntity) async {
    final todoCollectionRef =
        firestore.collection('users').doc(todoEntity.uid).collection('todos');

    todoCollectionRef.doc(todoEntity.todoId).get().then((todo) {
      if (todo.exists) {
        todoCollectionRef.doc(todoEntity.todoId).delete();
      }
      return;
    });
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollectionRef = firestore.collection('users');
    final uid = await getCurrentUId();

    userCollectionRef.doc(uid).get().then((value) {
      final newUser = UserModel(
        uid: uid,
        status: user.status,
        email: user.email,
        name: user.name,
      ).toDocument();

      if (!value.exists) {
        userCollectionRef.doc(uid).set(newUser);
      }
      return;
    });
  }

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  @override
  Stream<List<TodoEntity>> getTodos(String uid) {
    final todoCollectionRef =
        firestore.collection('users').doc(uid).collection('todos');

    return todoCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => TodoModel.fromScapshot(docSnap))
          .toList();
    });
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserEntity user) async => auth.signInWithEmailAndPassword(
      email: user.email!, password: user.password!);

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> signUp(UserEntity user) async =>
      auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

  @override
  Future<void> updateTodo(TodoEntity todo) async {
    Map<String, dynamic> todoMap = {};

    final todoCollectionRef =
        firestore.collection('users').doc(todo.uid).collection('todos');

    if (todo.todo != null) todoMap['todo'] = todo.todo;
    if (todo.time != null) todoMap['time'] = todo.time;

    todoCollectionRef.doc(todo.todoId).update(todoMap);
  }

  @override
  Future<UserEntity> getUser(UserEntity user) async {
    final userCollectionRef = firestore.collection('users');
    final uid = await getCurrentUId();

    final newUser = await userCollectionRef.doc(uid).get().then((value) {
      final newUser = UserModel(
        uid: uid,
        status: user.status,
        email: user.email,
        name: user.name,
      ).toDocument();

      if (!value.exists) {
        userCollectionRef.doc(uid).set(newUser);
      }
    });
    return newUser;
  }
}

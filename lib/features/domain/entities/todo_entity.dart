import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable{
  final String? todoId;
  final String? todo;
  final Timestamp? time;
  final String? uid;

  const TodoEntity({this.todoId, this.todo, this.time, this.uid});

  @override
  List<Object?> get props => [todoId, todo, time, uid];
}
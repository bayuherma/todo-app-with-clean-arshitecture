import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/features/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  const TodoModel({
    final String? todoId,
    final String? todo,
    final Timestamp? time,
    final String? uid,
  }) : super(
          uid: uid,
          todo: todo,
          time: time,
          todoId: todoId,
        );

  factory TodoModel.fromScapshot(DocumentSnapshot documentSnapshot) {
    return TodoModel(
      todoId: documentSnapshot.get('todoId'),
      todo: documentSnapshot.get('todo'),
      time: documentSnapshot.get('time'),
      uid: documentSnapshot.get('uid'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'todoId': todoId,
      'todo': todo,
      'time': time,
      'uid': uid,
    };
  }
}

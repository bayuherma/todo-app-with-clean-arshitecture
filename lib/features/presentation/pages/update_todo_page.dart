import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/domain/entities/todo_entity.dart';
import 'package:todo/features/presentation/cubit/todo/todo_cubit.dart';
import 'package:todo/features/presentation/widgets/common.dart';
import 'package:todo/theme.dart';

class updateTodoPage extends StatefulWidget {
  final TodoEntity todoEntity;
  const updateTodoPage({Key? key, required this.todoEntity}) : super(key: key);

  @override
  State<updateTodoPage> createState() => _updateTodoPageState();
}

class _updateTodoPageState extends State<updateTodoPage> {
  TextEditingController? _todoTextController;

  @override
  void initState() {
    _todoTextController = TextEditingController(text: widget.todoEntity.todo);
    super.initState();
  }

  @override
  void dispose() {
    _todoTextController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(1, 1),
                      blurRadius: 10,
                    ),
                  ]),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      color: kBlackColor.withOpacity(0.1),
                      height: 50,
                      child: Center(
                        child: TextFormField(
                          controller: _todoTextController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Start typing...',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      _submitUpdateTodo();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      primary: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      'SAVE',
                      style: kWhiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitUpdateTodo() {
    BlocProvider.of<TodoCubit>(context).updateTodo(
      todo: TodoEntity(
        todo: _todoTextController!.text,
        todoId: widget.todoEntity.todoId,
        time: Timestamp.now(),
        uid: widget.todoEntity.uid,
      ),
    );

    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }
}

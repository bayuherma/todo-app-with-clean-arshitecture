import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/domain/entities/todo_entity.dart';
import 'package:todo/features/presentation/cubit/todo/todo_cubit.dart';
import 'package:todo/features/presentation/widgets/common.dart';
import 'package:todo/theme.dart';

class AddNewTodoPage extends StatefulWidget {
  final String uid;
  const AddNewTodoPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<AddNewTodoPage> createState() => _AddNewTodoPageState();
}

class _AddNewTodoPageState extends State<AddNewTodoPage> {
  final TextEditingController _todoTextController = TextEditingController();

  @override
  void initState() {
    _todoTextController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _todoTextController.dispose();
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
                      submitNewTodo();
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

  void submitNewTodo() {
    if (_todoTextController.text.isEmpty) {
      snackBarError(context: context, msg: 'type something');
      return;
    }
    BlocProvider.of<TodoCubit>(context).addNewTodo(
      todo: TodoEntity(
        todo: _todoTextController.text,
        time: Timestamp.now(),
        uid: widget.uid,
      ),
    );

    Future.delayed(Duration(seconds: 1), (){
      Navigator.pop(context);
    });
  }
}

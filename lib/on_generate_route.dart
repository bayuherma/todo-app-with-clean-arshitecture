import 'package:flutter/material.dart';
import 'package:todo/app_const.dart';
import 'package:todo/features/domain/entities/todo_entity.dart';
import 'package:todo/features/presentation/pages/add_new_todo_page.dart';
import 'package:todo/features/presentation/pages/sign_in_page.dart';
import 'package:todo/features/presentation/pages/update_todo_page.dart';

import 'features/presentation/pages/sign_up_page.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.signInPage:
        {
          return materialBuilder(widget: SignInPage());
        }
      case PageConst.signUpPage:
        {
          return materialBuilder(widget: SignUpPage());
        }
      case PageConst.addNewTodoPage:
        {
          if (args is String) {
            return materialBuilder(
                widget: AddNewTodoPage(
              uid: args,
            ));
          }
          else {
            return materialBuilder(widget: ErrorPage());
          }
        }
      case PageConst.updateTodoPage:
        {
          if (args is TodoEntity) {
            return materialBuilder(
                widget: updateTodoPage(
              todoEntity: args,
            ));
          }
          else {
            return materialBuilder(widget: ErrorPage());
          }
        }
      default:
        return materialBuilder(widget: ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('error'),
      ),
      body: const Center(
        child: Text('Error'),
      ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}

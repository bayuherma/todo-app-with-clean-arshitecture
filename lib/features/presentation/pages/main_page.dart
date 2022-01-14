import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/presentation/cubit/todo/todo_cubit.dart';
import 'package:todo/features/presentation/pages/drawer/drawer_screen.dart';
import 'package:todo/features/presentation/pages/home/home_page.dart';

import '../../../theme.dart';

class MainPage extends StatefulWidget {
  final String uid;

  const MainPage({ Key? key, required this.uid }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    BlocProvider.of<TodoCubit>(context).getTodos(uid: widget.uid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            DrawerPage(uid: widget.uid),
            HomePage(uid: widget.uid)
          ],
        ),
      ),
      
    );
  }
}
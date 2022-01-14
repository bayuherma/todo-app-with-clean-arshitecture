import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app_const.dart';
import 'package:todo/features/domain/entities/user_entity.dart';
import 'package:todo/features/presentation/cubit/todo/todo_cubit.dart';
import 'package:todo/features/presentation/cubit/user/user_cubit.dart';
import 'package:todo/features/presentation/pages/home/widgets/card_view.dart';
import 'package:todo/features/presentation/pages/home/widgets/list_item.dart';
import 'package:todo/theme.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  double borderLeft = 0;
  double borderBottom = 0;

  UserEntity user = UserEntity();

  @override
  void initState() {
    BlocProvider.of<TodoCubit>(context).getTodos(uid: widget.uid);
    BlocProvider.of<UserCubit>(context).getUser(user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, todoState) {
        print(todoState is TodoLoaded);
        if (todoState is TodoLoaded) {
          print('loaded');
          return _bodyWidget(todoState);
        }
        print('loading');
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _nothingTodosWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Stack(
            children: [
              Opacity(
                  child: Image.asset('assets/images/notebook.png',
                      height: 150, color: Colors.black),
                  opacity: 0.5),
              ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Image.asset(
                    'assets/images/notebook.png',
                    height: 150,
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          'No todos here yet',
          style: kBlackTextStyle.copyWith(
            fontWeight: medium,
          ),
        ),
      ],
    );
  }

  Widget _bodyWidget(TodoLoaded todoLoadedState) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor),
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderLeft),
          bottomLeft: Radius.circular(borderBottom),
        ),
      ),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 104),
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, userState) {
                    if (userState is UserLoaded) {
                      print(userState.user.name);
                      return Text(
                        'Good Morning,\n${userState.user.name}',
                        style: kBlackTextStyle.copyWith(
                          fontSize: 24,
                          fontWeight: bold,
                        ),
                      );
                    }
                    print('user');

                    return Text(
                      'Good Morning,\nJohn',
                      style: kBlackTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: bold,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'Categories',
                  style: kGreyTextStyle.copyWith(fontWeight: medium),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: const [
                      CardView(),
                      CardView(),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Today\'s Tasks',
                  style: kGreyTextStyle.copyWith(fontWeight: medium),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 24),
                    child: todoLoadedState.todos.isEmpty
                        ? _nothingTodosWidget()
                        : ListView.builder(
                            itemCount: todoLoadedState.todos.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, PageConst.updateTodoPage, arguments: todoLoadedState.todos[index]);
                                },
                                child: ListItem(todoLoadedState: todoLoadedState, index: index,)
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
          customAppbar(),
          Positioned(
            right: 24,
            bottom: 24,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, PageConst.addNewTodoPage,
                    arguments: widget.uid);
              },
              backgroundColor: kSecondaryColor,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  // ListView _listItem(TodoLoaded todoLoadedState) {
  //   return ListView.builder(
  //     itemCount: todoLoadedState.todos.length,
  //     itemBuilder: (context, index) {
  //       return GestureDetector(
  //         onTap: () {},
  //         child: Container(
  //           width: double.infinity,
  //           height: 60,
  //           margin: const EdgeInsets.only(bottom: 12),
  //           padding: const EdgeInsets.only(right: 12),
  //           decoration: BoxDecoration(
  //             color: kWhiteColor,
  //             borderRadius: BorderRadius.circular(16),
  //           ),
  //           child: Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Checkbox(
  //                 value: false,
  //                 onChanged: (bool? value) {},
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //               ),
  //               Expanded(
  //                 child: Text(
  //                   '${todoLoadedState.todos[index].todo}',
  //                   style: kBlackTextStyle.copyWith(fontWeight: semiBold),
  //                   overflow: TextOverflow.ellipsis,
  //                   maxLines: 1,
  //                   softWrap: false,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  customAppbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      height: 80,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderLeft),
          bottomLeft: Radius.circular(borderBottom),
        ),
      ),
      child: Row(
        children: [
          isDrawerOpen
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      xOffset = 0;
                      yOffset = 0;
                      scaleFactor = 1;
                      isDrawerOpen = false;
                      borderLeft = 0;
                      borderBottom = 0;
                    });
                  },
                  child: Image.asset(
                    'assets/icons/back.png',
                    color: kPrimaryColor,
                    height: 24,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      xOffset = MediaQuery.of(context).size.width * 0.7;
                      yOffset = MediaQuery.of(context).size.height * 0.05;
                      scaleFactor = 0.9;
                      isDrawerOpen = true;
                      borderLeft = 24;
                      borderBottom = 24;
                    });
                  },
                  child: Image.asset(
                    'assets/icons/menu.png',
                    color: kPrimaryColor,
                    height: 24,
                  ),
                ),
          const Spacer(),
          Image.asset(
            'assets/icons/search.png',
            color: kPrimaryColor,
            height: 24,
          ),
          const SizedBox(width: 16),
          Image.asset(
            'assets/icons/notif.png',
            color: kPrimaryColor,
            height: 24,
          ),
        ],
      ),
    );
  }
}

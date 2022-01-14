import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:todo/features/presentation/cubit/todo/todo_cubit.dart';
import 'package:todo/features/presentation/cubit/user/user_cubit.dart';
import 'package:todo/features/presentation/pages/home/home_page.dart';
import 'package:todo/features/presentation/pages/main_page.dart';
import 'package:todo/features/presentation/pages/sign_in_page.dart';
import 'package:todo/on_generate_route.dart';
import 'injection.dart' as di;

import 'package:todo/screens/main_screen.dart';

import 'screens/splash_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider<UserCubit>(create: (_) => di.sl<UserCubit>()),
        BlocProvider<TodoCubit>(create: (_) => di.sl<TodoCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          '/': (context){
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {

                if(authState is Authenticated) {
                  print('Authenticated');

                  return MainPage(uid: authState.uid);
                }
                if(authState is UnAuthenticated) {
                  return SignInPage();
                }

                return CircularProgressIndicator();
              },
            );
          }
        },
      ),
    );
  }
}

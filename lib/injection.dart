import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/features/data/remote/datasources/firebase_remote_data_source_impl.dart';
import 'package:todo/features/data/repositories/firebase_repository_impl.dart';
import 'package:todo/features/domain/repositories/firebase_repository.dart';
import 'package:todo/features/domain/usecases/add_new_todo_usecase.dart';
import 'package:todo/features/domain/usecases/delete_todo_usecase.dart';
import 'package:todo/features/domain/usecases/get_create_current_user_usecase.dart';
import 'package:todo/features/domain/usecases/get_current_uid_usecase.dart';
import 'package:todo/features/domain/usecases/get_todos_usecase.dart';
import 'package:todo/features/domain/usecases/get_user_usecase.dart';
import 'package:todo/features/domain/usecases/is_sign_in_usecase.dart';
import 'package:todo/features/domain/usecases/sign_in_usecase.dart';
import 'package:todo/features/domain/usecases/sign_out_usecase.dart';
import 'package:todo/features/domain/usecases/sign_up_usecase.dart';
import 'package:todo/features/domain/usecases/update_todo_usecase.dart';
import 'package:todo/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:todo/features/presentation/cubit/todo/todo_cubit.dart';
import 'package:todo/features/presentation/cubit/user/user_cubit.dart';

import 'features/data/remote/datasources/firebase_remote_data_source.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  // Cubit/Bloc
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      getCurrentUIdUseCase: sl.call(),
      isSignInUseCase: sl.call(),
      signOutUseCase: sl.call(),
    ),
  );

  sl.registerFactory<UserCubit>(
    () => UserCubit(
      signInUseCase: sl.call(),
      signUpUseCase: sl.call(),
      getCreateCurrentUserUseCase: sl.call(),
      getUserUseCase: sl.call(),
    ),
  );

  sl.registerFactory<TodoCubit>(
    () => TodoCubit(
      updateTodoUseCase: sl.call(),
      deleteTodoUseCase: sl.call(),
      getTodosUserCase: sl.call(),
      addNewTodoUseCase: sl.call(),
    ),
  );

  // UserCase
  sl.registerLazySingleton<AddNewTodoUseCase>(
      () => AddNewTodoUseCase(repository: sl.call()));

  sl.registerLazySingleton<DeleteTodoUseCase>(
      () => DeleteTodoUseCase(repository: sl.call()));

  sl.registerLazySingleton<UpdateTodoUseCase>(
      () => UpdateTodoUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetCurrentUIdUseCase>(
      () => GetCurrentUIdUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetUserUseCase>(
      () => GetUserUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: sl.call()));

  sl.registerLazySingleton<GetTodosUserCase>(
      () => GetTodosUserCase(repository: sl.call()));

  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: sl.call()));

  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));

  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));

  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));

  // Repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

  // DataSource
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(auth: sl.call(), firestore: sl.call()));

  // External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}

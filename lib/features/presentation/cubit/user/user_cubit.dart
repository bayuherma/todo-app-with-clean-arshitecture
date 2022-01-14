import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/features/domain/entities/user_entity.dart';
import 'package:todo/features/domain/usecases/get_create_current_user_usecase.dart';
import 'package:todo/features/domain/usecases/get_user_usecase.dart';
import 'package:todo/features/domain/usecases/sign_in_usecase.dart';
import 'package:todo/features/domain/usecases/sign_up_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final GetCreateCurrentUserUseCase getCreateCurrentUserUseCase;
  final GetUserUseCase getUserUseCase;
  UserCubit({
    required this.getUserUseCase,
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.getCreateCurrentUserUseCase,
  }) : super(UserInitial());

  Future<void> submitSignIn({required UserEntity user}) async {
    emit(UserLoading());
    try {
      await signInUseCase.call(user);
      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> submitSignUp({required UserEntity user}) async {
    emit(UserLoading());

    try {
      await signUpUseCase.call(user);
      await getCreateCurrentUserUseCase.call(user);
      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }

    // Future<void> getUser({required UserEntity user}) async {
    //   emit(UserLoading());

    //   try {
    //     await getUserUseCase.call(user);
    //     emit(UserLoaded(user: user));
    //   } on SocketException catch (_) {
    //     emit(UserFailure());
    //   } catch (_) {
    //     emit(UserFailure());
    //   }
    // }
  }

  Future<void> getUser(UserEntity user) async {
    emit(UserLoading());

    try {
      await getUserUseCase.call(user);
      emit(UserLoaded(user: user));
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}

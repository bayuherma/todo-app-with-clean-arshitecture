
import 'package:todo/features/domain/repositories/firebase_repository.dart';

class GetCurrentUIdUseCase {
  final FirebaseRepository repository;

  GetCurrentUIdUseCase({required this.repository});

  Future<String> call()async {
    return repository.getCurrentUId();
  }
}
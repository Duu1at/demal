import 'package:auth_repository/auth_repository.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppleSignCubit extends Cubit<RequestStatus<void>> {
  AppleSignCubit(this.authRepository) : super(const RequestInitial());

  final AuthRepository authRepository;

  Future<void> signInWithApple() async {
    if (state is RequestLoading) return;
    try {
      emit(RequestLoading());
      await authRepository.signInWithApple();
      emit(const RequestSuccess(null));
    } on Object catch (e) {
      emit(RequestFailure(e));
    }
  }
}

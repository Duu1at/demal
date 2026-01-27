import 'package:auth_repository/auth_repository.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleSignCubit extends Cubit<RequestStatus<void>> {
  GoogleSignCubit(this.authRepository) : super(const RequestInitial());

  final AuthRepository authRepository;

  Future<void> signInWithGoogle() async {
    if (state is RequestLoading) return;
    try {
      emit(RequestLoading());
      await authRepository.signInWithGoogle();
      emit(const RequestSuccess(null));
    } on Object catch (e) {
      emit(RequestFailure(e));
    }
  }
}

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_repository/profile_repository.dart';

class VerifyStatusCubit extends Cubit<RequestStatus<PartnerVerifyStatusModel>> {
  VerifyStatusCubit(this.profileRepository) : super(const RequestInitial());

  final ProfileRepository profileRepository;

  Future<void> getVerifyStatus() async {
    if (state is RequestLoading) return;
    try {
      emit(RequestLoading());
      final profile = await profileRepository.getPartnerVerifyStatus();
      emit(RequestSuccess(profile));
    } on Object catch (e) {
      emit(RequestFailure(e));
    }
  }
}

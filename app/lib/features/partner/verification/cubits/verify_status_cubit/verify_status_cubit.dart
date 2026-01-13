import 'package:core/status/request_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_repository/profile_repository.dart';

class VerifyStatusCubit extends Cubit<RequestStatus<PartnerVerifyStatusModel>> {
  VerifyStatusCubit(this.profileRepository) : super(const RequestInitial());
  final ProfileRepository profileRepository;

  Future<void> getVerifyStatus() async {
    try {
      emit(RequestLoading());
      final result = await profileRepository.getPartnerVerifyStatus();
      emit(RequestSuccess(result));
    } on Object catch (e) {
      emit(RequestFailure(e));
    }
  }
}

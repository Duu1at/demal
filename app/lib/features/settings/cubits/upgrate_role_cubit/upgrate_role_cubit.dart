import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_repository/profile_repository.dart';

class UpgrateRoleCubit extends Cubit<RequestStatus<UserModel>> {
  UpgrateRoleCubit(this.profileRepository) : super(const RequestInitial());

  final ProfileRepository profileRepository;

  Future<void> upgradeToPartner() async {
    if (state is RequestLoading) return;
    try {
      emit(RequestLoading());
      final profile = await profileRepository.upgradeToPartner();
      emit(RequestSuccess(profile));
    } on Object catch (e) {
      emit(RequestFailure(e));
    }
  }
}

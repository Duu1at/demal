import 'package:app/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VersionCheckCubit extends Cubit<UpdateType> {
  VersionCheckCubit(this._versionCheckService) : super(UpdateType.none);

  final VersionCheckService _versionCheckService;

  Future<void> checkVersion() async {
    final updateType = await _versionCheckService.checkVersion();
    emit(updateType);
  }

  void launchStore() => _versionCheckService.launchStore();
}

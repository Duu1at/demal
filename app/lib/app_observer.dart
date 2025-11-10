import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver(this.talker);
  final Talker talker;

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    talker.info('💡 [CREATE] ${bloc.runtimeType} created');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    talker
      ..info('🔄 [CHANGE] ${bloc.runtimeType}')
      ..info('    │ CURRENT: ${change.currentState}')
      ..info('    │ NEXT:    ${change.nextState}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    talker.info('📩 [EVENT] ${bloc.runtimeType} → $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    talker
      ..info('⚡ [TRANSITION] ${bloc.runtimeType}')
      ..info('    │ EVENT: ${transition.event}')
      ..info('    │ CURRENT: ${transition.currentState}')
      ..info('    │ NEXT: ${transition.nextState}');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    talker.info('❌ [CLOSE] ${bloc.runtimeType} closed');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    talker
      ..error('🚨 [ERROR] ${bloc.runtimeType} → $error')
      ..error(stackTrace.toString());
  }
}

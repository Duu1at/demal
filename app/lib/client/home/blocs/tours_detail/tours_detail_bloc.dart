import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tours_detail_event.dart';
part 'tours_detail_state.dart';

class ToursDetailBloc extends Bloc<ToursDetailEvent, ToursDetailState> {
  ToursDetailBloc() : super(ToursDetailInitial()) {
    on<ToursDetailEvent>((event, emit) {});
  }
}

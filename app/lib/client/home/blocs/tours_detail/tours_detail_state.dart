part of 'tours_detail_bloc.dart';

sealed class ToursDetailState extends Equatable {
  const ToursDetailState();

  @override
  List<Object> get props => [];
}

final class ToursDetailInitial extends ToursDetailState {}

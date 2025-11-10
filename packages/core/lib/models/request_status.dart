import 'package:equatable/equatable.dart';

sealed class RequestStatus<T> extends Equatable {
  const RequestStatus();

  @override
  List<Object?> get props => [];
  bool get isInitial => this is RequestInitial;
  bool get isLoading => this is RequestLoading;
  bool get isSuccess => this is RequestSuccess;
  bool get isFailure => this is RequestFailure;
  bool get isInitLoading => isInitial || isLoading;
  bool get notInitLoading => !isInitial && !isLoading;
}

final class RequestInitial<T> extends RequestStatus<T> {
  const RequestInitial();
}

final class RequestLoading<T> extends RequestStatus<T> {}

final class RequestSuccess<T> extends RequestStatus<T> {
  const RequestSuccess(this.data);

  final T? data;

  @override
  List<Object?> get props => [data];
}

final class RequestFailure<T> extends RequestStatus<T> {
  const RequestFailure(this.exception);

  final Object exception;

  @override
  List<Object?> get props => [exception];
}

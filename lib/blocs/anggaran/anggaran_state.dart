part of 'anggaran_bloc.dart';

sealed class AnggaranState extends Equatable {
  const AnggaranState();

  @override
  List<Object> get props => [];
}

final class AnggaranInitial extends AnggaranState {}

final class AnggaranLoading extends AnggaranState {}

final class AnggaranSuccess extends AnggaranState {}

final class AnggaranError extends AnggaranState {
  final String e;
  const AnggaranError(this.e);

  @override
  List<Object> get props => [e];
}

final class StreamAnggaranSuccess extends AnggaranState {
  final List<AnggaranModel> data;
  const StreamAnggaranSuccess(this.data);

  @override
  List<Object> get props => [data];
}

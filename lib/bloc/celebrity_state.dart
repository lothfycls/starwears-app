part of 'celebrity_bloc.dart';

@immutable
abstract class CelebrityState {}

class CelebrityInitial extends CelebrityState {}
class CelebritiesReady extends CelebrityState {
  final List<Celebrity> celebrities;
  CelebritiesReady({
    required this.celebrities,
  });
}

class CelebritiesFailed extends CelebrityState {
  final String error;
  CelebritiesFailed({
    required this.error,
  });
}

part of 'relationship_bloc.dart';

@immutable
abstract class RelationshipState {}

class RelationshipInitial extends RelationshipState {}

class AlreadyState extends RelationshipState {
  final Relationship relationship;
  AlreadyState({required this.relationship});
}

class RelationshipFailed extends RelationshipState {
  final String error;
  RelationshipFailed({required this.error});
}

class NeverState extends RelationshipState {
  final Relationship relationship;
  NeverState({required this.relationship});
}

class OutbiddedState extends RelationshipState {
  final Relationship relationship;
  OutbiddedState({required this.relationship});
}

class WonState extends RelationshipState {
  final Relationship relationship;
  WonState({required this.relationship});
}

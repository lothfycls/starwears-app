part of 'relationship_bloc.dart';

@immutable
abstract class RelationshipEvent {}

class GetRelationShip extends RelationshipEvent {
  final int productId;
  GetRelationShip({required this.productId});
}

part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}
class CategoriesReady extends CategoryState {
  final List<Category> categories;
  CategoriesReady({
    required this.categories,
  });
}

class CategoriesFailed extends CategoryState {
  final String error;
  CategoriesFailed({
    required this.error,
  });
}

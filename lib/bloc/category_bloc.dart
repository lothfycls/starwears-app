import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starwears/models/category.dart';
import 'package:starwears/services/categories_service.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoriesService categoriesService = CategoriesService();
  List<Category> currentCategories = [];
  CategoryBloc() : super(CategoryInitial()) {
    on<GetCategories>((event, emit) async {
      try {
        List<Category> categories = await categoriesService.getCategories();
        currentCategories = categories;
        emit(CategoriesReady(categories: categories));
      } catch (e) {
        emit(CategoriesFailed(error: e.toString()));
      }
    });
  }
}

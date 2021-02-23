import 'package:budget_app/model/model.dart';
import 'package:budget_app/repository.dart';

class CategoryService {
  Repository _repository;

  CategoryService() {
    _repository = Repository();
  }

  saveCategory(Category category) async {
    print(category);
    return await _repository.insertData('categories', category.categoryMap());
  }

  readCategories() async {
    return _repository.readData('categories');
  }
}

import '../entities/meal.dart';
import '../repositories/nutrition_repository.dart';

class GetSmartMeals {
  final NutritionRepository repository;

  GetSmartMeals(this.repository);

  Future<List<Meal>> call() async {
    return await repository.getSmartMeals();
  }
}

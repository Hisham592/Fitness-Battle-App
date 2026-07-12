import '../repositories/nutrition_repository.dart';

class LogMealAsEaten {
  final NutritionRepository repository;

  LogMealAsEaten(this.repository);

  Future<void> call(String mealId) async {
    return await repository.logMealAsEaten(mealId);
  }
}

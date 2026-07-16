import '../entities/meal.dart';

abstract class NutritionRepository {
  Future<List<Meal>> getSmartMeals();
  Future<void> logMealAsEaten(String mealId);
}

import '../models/meal_model.dart';

abstract class NutritionLocalDataSource {
  Future<List<MealModel>> getCachedMeals();
  Future<void> cacheMeals(List<MealModel> mealsToCache);
}

class NutritionLocalDataSourceImpl implements NutritionLocalDataSource {
  // Inject Hive box or Shared Preferences here
  NutritionLocalDataSourceImpl();

  @override
  Future<List<MealModel>> getCachedMeals() async {
    // Fetch from local local persistence
    return [];
  }

  @override
  Future<void> cacheMeals(List<MealModel> mealsToCache) async {
    // Save locally
  }
}

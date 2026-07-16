import '../../domain/entities/meal.dart';
import '../../domain/repositories/nutrition_repository.dart';
import '../datasources/nutrition_local_data_source.dart';
import '../datasources/nutrition_remote_data_source.dart';

class NutritionRepositoryImpl implements NutritionRepository {
  final NutritionRemoteDataSource remoteDataSource;
  final NutritionLocalDataSource localDataSource;

  NutritionRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Meal>> getSmartMeals() async {
    try {
      // 1. Fetch from server
      final remoteMeals = await remoteDataSource.fetchSmartMeals();
      // 2. Refresh local Cache
      await localDataSource.cacheMeals(remoteMeals);
      return remoteMeals;
    } catch (_) {
      // 3. Fallback to cache if server is down / offline
      return await localDataSource.getCachedMeals();
    }
  }

  @override
  Future<void> logMealAsEaten(String mealId) async {
    await remoteDataSource.sendMealLoggedStatus(mealId);
  }
}

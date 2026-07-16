import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voz_app/core/widgets/appbar_title_widget.dart';
import '../../domain/entities/meal.dart';
import '../widgets/meal_item_card.dart';
import 'meal_details_screen.dart';

class SmartNutritionScreen extends StatefulWidget {
  const SmartNutritionScreen({super.key});

  @override
  State<SmartNutritionScreen> createState() => _SmartNutritionScreenState();
}

class _SmartNutritionScreenState extends State<SmartNutritionScreen> {
  String _selectedFilter = 'Default';

  final List<Meal> localizedMeals = [
    const Meal(
      id: '1',
      title: 'Grilled Chicken Salad',
      graphic: '🥗',
      calories: 420,
      priceEgp: 45,
      proteinGrams: 38,
      carbsGrams: 22,
      fatsGrams: 14,
      prepTime: '20 min',
      instructions:
          'Grill chicken breast seasoned with cumin, coriander, and lemon zest. Slice and serve over mixed greens with cucumber, tomato, and red onion. Finish with tahini dressing and a squeeze of fresh lime. Pairs well with a side of whole-grain pita.',
    ),
    Meal(
      id: '2',
      title: 'Koshary Bowl',
      graphic: '🍲',
      calories: 380,
      priceEgp: 20,
      proteinGrams: 10,
      carbsGrams: 100,
      fatsGrams: 4,
      prepTime: '30 min',
      instructions:
          'Layer cooked rice, lentils, pasta, and fried onions in a bowl. Finish with a drizzle of tomato sauce and a spoonful of garlic vinegar for a hearty finish.',
      containerColor: const Color(0xFF1A1610),
    ),
    Meal(
      id: '3',
      title: 'Tuna Sandwich',
      graphic: '🥪',
      calories: 310,
      priceEgp: 25,
      proteinGrams: 15,
      carbsGrams: 80,
      fatsGrams: 4,
      prepTime: '15 min',
      instructions:
          'Mash tuna with light mayo, mustard, and chopped celery. Spread onto toasted bread with crisp lettuce and tomato for a quick lunch.',
      containerColor: const Color(0xFF10161A),
    ),
    Meal(
      id: '4',
      title: 'Ful Medames',
      graphic: '🫘',
      calories: 280,
      priceEgp: 12,
      proteinGrams: 18,
      carbsGrams: 95,
      fatsGrams: 8,
      prepTime: '35 min',
      instructions:
          'Simmer fava beans with garlic, olive oil, and lemon until creamy. Serve warm with olive oil, chopped onions, and fresh herbs.',
      containerColor: const Color(0xFF1A1610),
    ),
    Meal(
      id: '5',
      title: 'Protein Omelette',
      graphic: '🍳',
      calories: 350,
      priceEgp: 30,
      proteinGrams: 18,
      carbsGrams: 95,
      fatsGrams: 8,
      prepTime: '15 min',
      instructions:
          'Whisk eggs with herbs, black pepper, and a splash of milk. Cook gently in a nonstick pan and serve with sliced avocado and tomato.',
      containerColor: const Color(0xFF1A1111),
    ),
  ];

  List<Meal> _getSortedMeals() {
    List<Meal> sortedList = List.from(localizedMeals);
    if (_selectedFilter == 'Calories') {
      sortedList.sort((a, b) => a.calories.compareTo(b.calories));
    } else if (_selectedFilter == 'Price') {
      sortedList.sort((a, b) => a.priceEgp.compareTo(b.priceEgp));
    } else if (_selectedFilter == 'Default') {
      return localizedMeals;
    }
    return sortedList;
  }

  @override
  Widget build(BuildContext context) {
    final displayMeals = _getSortedMeals();

    return Scaffold(
      appBar: AppBar(
        title: AppBarTitleWidget(title: "SMART NUTRATION"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: Colors.grey.withValues(alpha: 0.3),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '50+ local meals · Priced in EGP',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff444444),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: const Color(0xff181818),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.r),
                        ),
                      ),
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 20.h,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  width: 40.w,
                                  height: 4.h,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff555555),
                                    borderRadius: BorderRadius.circular(2.r),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                'Filter Meals By',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 16.h),

                              ListTile(
                                leading: const Icon(
                                  Icons.restart_alt,
                                  color: Color(0xffDF00FF),
                                ),
                                title: Text(
                                  'Default Order',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    _selectedFilter = 'Default';
                                  });
                                },
                              ),
                              const Divider(color: Color(0xff2E2E2E)),

                              ListTile(
                                leading: const Icon(
                                  Icons.local_fire_department,
                                  color: Color(0xffDF00FF),
                                ),
                                title: Text(
                                  'Calories',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    _selectedFilter = 'Calories';
                                  });
                                },
                              ),
                              const Divider(color: Color(0xff2E2E2E)),

                              ListTile(
                                leading: const Icon(
                                  Icons.payments,
                                  color: Color(0xffDF00FF),
                                ),
                                title: Text(
                                  'Price',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    _selectedFilter = 'Price';
                                  });
                                },
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffDF00FF).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(
                        color: const Color(0xffDF00FF).withValues(alpha: 0.22),
                        width: 1.w,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      child: Text(
                        _selectedFilter == 'Default'
                            ? 'FILTER'
                            : 'BY ${_selectedFilter.toUpperCase()}',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xffDF00FF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              itemCount: displayMeals.length,
              separatorBuilder: (_, _) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final meal = displayMeals[index];
                return MealItemCard(
                  meal: meal,
                  graphicContainerColor: meal.containerColor,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MealDetailsScreen(meal: meal),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


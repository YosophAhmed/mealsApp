import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(
    this.availableMeals,
  );

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  bool loadedInitialData = false;

  @override
  void didChangeDependencies() {
    if (!loadedInitialData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];

      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      loadedInitialData = true;
    }
    super.didChangeDependencies();
  }

  void removeMeal(String mealID) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => MealItem(
          id: displayedMeals[index].id,
          title: displayedMeals[index].title,
          imageUrl: displayedMeals[index].imageUrl,
          duration: displayedMeals[index].duration,
          complexity: displayedMeals[index].complexity,
          affordability: displayedMeals[index].affordability,
        ),
        itemCount: displayedMeals.length,
      ),
    );
  }
}

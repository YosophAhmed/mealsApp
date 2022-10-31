import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/tabs_screen.dart';
import 'models/meal.dart';
import 'screens/categories_screen.dart';
import 'screens/category_meals_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;
      availableMeals = DUMMY_MEALS.where((meal) {
        if (filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFavorite(String mealId) {
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool isMealFavorite(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(
              favoriteMeals,
            ),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(
              availableMeals,
            ),
        MealDetailScreen.routeName: (context) => MealDetailScreen(
          toggleFavorite,
          isMealFavorite,
            ),
        FiltersScreen.routeName: (context) => FiltersScreen(
              filters,
              setFilters,
            ),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => CategoriesScreen(),
        );
      },
    );
  }
}

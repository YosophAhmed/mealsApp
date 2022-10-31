import 'package:flutter/material.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/widgets/main_drawer.dart';
import '../models/meal.dart';
import 'favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabsScreen(
    this.favoriteMeals,
  );

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> pages;
  int selectedIndex = 0;

  void selectPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreen(widget.favoriteMeals,),
        'title': 'Your Favorites',
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          pages[selectedIndex]['title'],
        ),
      ),
      drawer: MainDrawer(),
      body: pages[selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'favorites',
          ),
        ],
      ),
    );
  }
}

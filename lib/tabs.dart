import 'package:flutter/material.dart';
import 'package:food_tasks/categories.dart';
import 'package:food_tasks/meal.dart';
import 'package:food_tasks/meals.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      _favoriteMeals.remove(meal);
    } else {
      _favoriteMeals.add(meal);
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  late Widget activePage;
  late var activePageTitle;
  @override
  void initState() {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: toggleMealFavoriteStatus,
    );
    var activePageTitle = 'Categories';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedPageIndex == 1) {
      activePageTitle = 'Your Favorites';
      activePage = MealsScreen(
        meals: [],
        onToggleFavorite: toggleMealFavoriteStatus,
      );
    } else {
      activePageTitle = 'Categories';
      activePage = CategoriesScreen(
        onToggleFavorite: toggleMealFavoriteStatus,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
        onTap: (index) {
          _selectPage(index);
        },
        currentIndex: _selectedPageIndex,
      ),
    );
  }
}

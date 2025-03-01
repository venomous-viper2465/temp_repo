import 'package:flutter/material.dart';
import 'package:food_tasks/categories.dart';
import 'package:food_tasks/meals_provider.dart';
import 'package:food_tasks/filters.dart';
import 'package:food_tasks/main_drawer.dart';
import 'package:food_tasks/meal.dart';
import 'package:food_tasks/meals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_tasks/favorites_provider.dart';
import 'package:food_tasks/filters_provider.dart';

const kInititalFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedPageIndex = 0;
  Map<Filter, bool> _selectedFilters = kInititalFilter;

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
      availableMeals: [],
    );
    var activePageTitle = 'Categories';
    super.initState();
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
              builder: (ctx) => FiltersScreen(
                    currentFilters: _selectedFilters,
                  )));

      setState(() {
        _selectedFilters = result ?? kInititalFilter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePageTitle = 'Your Favorites';
      activePage = MealsScreen(
        meals: _favoriteMeals,
      );
    } else {
      activePageTitle = 'Categories';
      activePage = CategoriesScreen(
        availableMeals: availableMeals,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
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

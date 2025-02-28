import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_tasks/meal.dart';
import 'package:food_tasks/meals.dart';
import 'category.dart';
import 'dummy_data.dart';
import 'category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen(
      {super.key,
      required this.onToggleFavorite,
      required this.availableMeals});
  final List<Meal> availableMeals;
  void Function(Meal meal) onToggleFavorite;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (ctx) => MealsScreen(
                title: category.title,
                meals: filteredMeals,
                onToggleFavorite: onToggleFavorite,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectCategory(context, category);
            },
          )
      ],
    );
  }
}

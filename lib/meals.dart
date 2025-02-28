import 'package:flutter/material.dart';
import 'package:food_tasks/meal_details_screen.dart';
import 'package:food_tasks/meal_item.dart';
import 'meal.dart';

class MealsScreen extends StatelessWidget {
  MealsScreen(
      {super.key,
      this.title,
      required this.meals,
      required this.onToggleFavorite});

  final String? title;
  final List<Meal> meals;
  void Function(Meal meal) onToggleFavorite;

  void selectMeal(BuildContext context, meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (ctx) => MealDetails(
                meal: meal,
                onToggleFavorite: onToggleFavorite,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemBuilder: (ctx, index) => MealItem(
        meal: meals[index],
        onSelectMeal: (meal) {
          selectMeal(context, meal);
        },
      ),
      itemCount: meals.length,
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh... nothing here',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Try selecting a different category',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            )
          ],
        ),
      );
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}

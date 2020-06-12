import 'package:cozinhapp/data/dummy_data.dart';
import 'package:cozinhapp/model/meal.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  var pageController = PageController();

  @observable
  int selectedIndex = 0;

  @action
  void changePage(int i) {
    pageController.jumpToPage(i);
    selectedIndex = i;
  }

  @observable
  ObservableList<Meal> meals = [...DUMMY_MEALS].asObservable();

  @observable
  String filter = '';

  @action
  void setFilter(String value) => filter = value;

  @computed
  List<Meal> get filteredList {
    List<Meal> filteredMeals = [];

    if (filter.isEmpty) {
      return [];
    }
    for (var meal in meals) {
      for (var ingredient in meal.ingredients) {
        if (!filteredMeals.contains(meal) &&
            ingredient.toLowerCase().contains(filter)) {
          filteredMeals.add(meal);
        }
      }
    }
    return filteredMeals;
  }

  @computed
  ObservableList<Meal> get listFavoriteMeals =>
      meals.where((meal) => meal.isFavorite).toList().asObservable();

  @action
  void toggleFavorite(Meal meal) {
    int index = meals.indexWhere((element) => element.id == meal.id);
    meals[index].isFavorite = !meals[index].isFavorite;
    print(meals[index].isFavorite);
  }

  // @action
  // void removeFavorite(Meal meal) {
  //   if (favoriteMeals.contains(meal)) {
  //     meal.isFavorite = false;
  //     favoriteMeals.remove(meal);
  //   }
  // }
}

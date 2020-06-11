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

  ObservableList<Meal> meals = DUMMY_MEALS.asObservable();

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
    for (var m in meals) {
      for (var i in m.ingredients) {
        if (!filteredMeals.contains(m) && i.toLowerCase().contains(filter)) {
          filteredMeals.add(m);
        }
      }
    }
    return filteredMeals;
  }

  @computed
  ObservableList<Meal> get listFavoriteMeals =>
      meals.where((meal) => meal.isFavorite).toList().asObservable();
  // @action
  // void addFavorite(Meal meal) {
  //   meal.isFavorite = true;
  //   favoriteMeals.add(meal);
  // }

  // @action
  // void removeFavorite(Meal meal) {
  //   if (favoriteMeals.contains(meal)) {
  //     meal.isFavorite = false;
  //     favoriteMeals.remove(meal);
  //   }
  // }
}

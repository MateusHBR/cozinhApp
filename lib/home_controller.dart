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

  List<Meal> meals = DUMMY_MEALS;

  @observable
  String filter = '';

  @action
  void setFilter(String value) => filter = value;

  //TODO: Fazer com que percorra todo vetor de ingredientes.
  @computed
  List<Meal> get filteredList {
    if (filter.isEmpty) {
      return [];
    }
    return meals
        .where((meal) => meal.ingredients[0].toLowerCase().contains(filter))
        .toList();
  }
}

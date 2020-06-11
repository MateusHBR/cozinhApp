import 'package:cozinhapp/home_controller.dart';
import 'package:cozinhapp/widgets/meal_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);
    // var size = MediaQuery.of(context).size;
    return Container(
      child: LayoutBuilder(
        builder: (_, constraint) {
          return Column(
            children: <Widget>[
              Container(
                height: constraint.maxHeight,
                width: double.infinity,
                child: Observer(
                  builder: (_) {
                    return ListView.builder(
                      itemCount: controller.listFavoriteMeals.length,
                      itemBuilder: (ctx, index) {
                        return Observer(
                          builder: (_) {
                            return MealItem(
                              meal: controller.listFavoriteMeals[index],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

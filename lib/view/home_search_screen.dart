import 'package:cozinhapp/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../widgets/meal_item.dart';

class HomeSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);
    var size = MediaQuery.of(context).size;
    return Container(
      child: LayoutBuilder(
        builder: (_, constraint) {
          return Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06,
                  vertical: size.height * 0.02,
                ),
                height: 50,
                child: TextField(
                  onChanged: controller.setFilter,
                  decoration: InputDecoration(
                    hintText: 'Pesquise...',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              // Divider(),
              Container(
                height: constraint.maxHeight - 50 - (size.height * 0.04),
                width: double.infinity,
                child: Observer(
                  builder: (_) {
                    return ListView.builder(
                      itemCount: controller.filteredList.length,
                      itemBuilder: (ctx, index) {
                        return MealItem(
                          meal: controller.filteredList[index],
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

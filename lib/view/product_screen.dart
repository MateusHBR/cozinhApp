import 'package:cozinhapp/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../model/meal.dart';

class ProductScreen extends StatelessWidget {
  final Meal meal;

  const ProductScreen({Key key, this.meal}) : super(key: key);

  _createSectionTitle(BuildContext context, String title, size) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Widget _createSectionContainer({Widget child, size}) {
    return Container(
      width: size.width * 0.8,
      height: size.height * 0.3,
      padding: EdgeInsets.all(size.height * 0.015),
      margin: EdgeInsets.all(size.height * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeController>(context);

    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: size.height * 0.3,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _createSectionTitle(context, 'Ingredientes', size),
            _createSectionContainer(
              child: ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.014,
                        horizontal: size.width * 0.025,
                      ),
                      child: Text(meal.ingredients[index]),
                    ),
                    color: Theme.of(context).accentColor,
                  );
                },
              ),
              size: size,
            ),
            _createSectionTitle(context, 'Passos', size),
            _createSectionContainer(
              size: size,
              child: ListView.separated(
                itemCount: meal.steps.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('#${index + 1}'),
                    ),
                    title: Text(meal.steps[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.star_border),
      //   onPressed: () {},
      // ),
      floatingActionButton: Observer(
        builder: (_) {
          return FloatingActionButton(
            child: Observer(
              builder: (_) {
                return Icon(
                  homeController
                          .meals[homeController.meals
                              .indexWhere((element) => element.id == meal.id)]
                          .isFavorite
                      ? Icons.star
                      : Icons.star_border,
                );
              },
            ),
            onPressed: () {
              homeController.toggleFavorite(meal);
            },
          );
        },
      ),
    );
  }
}

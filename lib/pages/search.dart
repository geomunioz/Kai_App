import 'package:app_eat/utils/routes.dart';
import 'package:app_eat/widgets/category.dart';
import 'package:flutter/material.dart';
import 'package:app_eat/widgets/colors.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        title: Text('Busqueda'),
        titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: black,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: (){
                _nextScreen(searchProducts_route, '');
              },
              child: TextField(
                enabled: false,
                style: TextStyle(
                    color: gray
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: black50,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: black50),
                  ),
                  hintText: 'Producto, Categoria, Establecimiento...',
                  hintStyle: TextStyle(
                    color: gray,
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: gray,
                  ),
                ),
              ),
            ),
            GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 0.5,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: 1.2,
                children: [
                  Category(
                    name: 'Paquetes',
                    url: 'assets/images/pack.png',
                    color: paquetes,
                    onTap: (){
                      _nextScreen(categoryProduct_route, 'Paquetes');
                    },
                  ),
                  Category(
                    name: 'Gratis',
                    url: 'assets/images/free.png',
                    color: gratis,
                    onTap: (){
                      _nextScreen(categoryProduct_route, 'Gratis');
                    },
                  ),
                  Category(
                    name: 'Frutas',
                    url: 'assets/images/fruits.png',
                    color: frutas,
                    onTap: (){
                      _nextScreen(categoryProduct_route, 'Frutas');
                    },
                  ),
                  Category(
                    name: 'Verduras',
                    url: 'assets/images/vegetables.png',
                    color: verduras,
                    onTap: (){
                      _nextScreen(categoryProduct_route, 'Verduras');
                    },
                  ),
                  Category(
                    name: 'Carnes',
                    url: 'assets/images/meat.png',
                    color: carnes,
                    onTap: (){
                      _nextScreen(categoryProduct_route, 'Carnes');
                    },
                  ),
                  Category(
                    name: 'Postres',
                    url: 'assets/images/dessert.png',
                    color: postres,
                    onTap: (){
                      _nextScreen(categoryProduct_route, 'Postres');
                    },
                  ),
                  Category(
                    name: 'Bebidas',
                    url: 'assets/images/drinks.png',
                    color: bebidas,
                    onTap: (){
                      _nextScreen(categoryProduct_route, 'Bebidas');
                    },
                  ),
                  Category(
                    name: 'Preparados',
                    url: 'assets/images/foods.png',
                    color: preparados,
                    onTap: (){
                      _nextScreen(categoryProduct_route, 'Alimentos Preparados');
                    },
                  ),
                ]
            ),
          ],
        ),
      ),
    );
  }

  void _nextScreen(String route, String category) {
    final args = {"category_args": category};
    Navigator.pushNamed(context, route, arguments: args);
  }
}

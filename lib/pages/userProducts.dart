import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

import 'package:app_eat/widgets/colors.dart';
import 'package:app_eat/widgets/productCard.dart';

import 'package:app_eat/utils/routes.dart';
import 'package:app_eat/utils/strings.dart';

import 'package:app_eat/data/domain/product.dart';

import 'package:app_eat/data/usecases/GetUserIdUseCase.dart';
import 'package:app_eat/data/usecases/GetProductsUseCase.dart';

class UserProducts extends StatefulWidget {
  const UserProducts({Key? key}) : super(key: key);

  @override
  _UserProductsState createState() => _UserProductsState();
}

class _UserProductsState extends State<UserProducts> {
  final _getUserIdUseCase = Injector.appInstance.get<GetUserIdUseCase>();
  final _getProductsUseCase = Injector.appInstance.get<GetProductsUseCase>();

  late String? _userId;

  late Stream<List<Product>> _listProductStream;
  List<Product> _listProducts = [];

  @override
  void initState() {
    _userId = _getUserIdUseCase.invoke();

    _listProductStream = _getProductsUseCase.invoke().asStream();
    super.initState();

    /*WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getArguments();
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
        ),
        title: Text('Productos'),
        backgroundColor: black,
        actions: <Widget>[
          IconButton(
              onPressed: () => _nextScreen(
                  newProduct_route,
              ),
              icon: Icon(Icons.add)
          ),
        ],
      ),
      body: SafeArea(
        child: new StreamBuilder<List<Product>>(
            stream: _listProductStream,
            builder: (BuildContext context, AsyncSnapshot<List<Product>?> snapshot){
              if (snapshot.hasError) {
                return hasError(alert_title_error);
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return waitingConnection();
              }
              if (snapshot.data!.isEmpty) {
                return hasError(alert_content_is_empty);
              }else {
                _listProducts = productsUser(snapshot.data!);//snapshot.data!;
                /*_getUserTests();*/
                return GridView.builder(
                  itemCount: _listProducts.length,
                  padding: EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 170.0,
                    maxCrossAxisExtent: 200.0,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return new ProductCard(
                      name: _listProducts[index].name,
                      urlImage: _listProducts[index].urlImage,
                      idUser: _listProducts[index].idUser,
                      price: _listProducts[index].price,
                      onTap: () {
                        _nextScreenProduct(productDetail_route, _listProducts[index]);
                      },
                    );
                  },
                );
              }
            }
        ),
      ),
    );
  }

  void _nextScreen(String route) {
    Navigator.pushNamed(context, route);
  }

  void _nextScreenProduct(String route, Product product) {
    final args = {"product_args": product};
    Navigator.pushNamed(context, route, arguments: args);
  }

  Center waitingConnection() {
    return Center(
      child: SizedBox(
        child: CircularProgressIndicator(
          strokeWidth: 5,
        ),
        width: 75,
        height: 75,
      ),
    );
  }

  Center hasError(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: green100,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  List<Product> productsUser(List<Product> products){
    for(int i = 0; i<products.length; i++){
      if(products[i].idUser==_userId){
        _listProducts.add(products[i]);
      }
    }
    return _listProducts;
  }
}

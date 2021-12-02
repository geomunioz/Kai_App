import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

import 'package:app_eat/data/usecases/GetUserIdUseCase.dart';
import 'package:app_eat/data/usecases/GetProductsUseCase.dart';

import 'package:app_eat/widgets/productCard.dart';
import 'package:app_eat/widgets/colors.dart';

import 'package:app_eat/utils/routes.dart';
import 'package:app_eat/utils/strings.dart';

import 'package:app_eat/data/domain/product.dart';

class SearchProducts extends StatefulWidget {
  const SearchProducts({Key? key}) : super(key: key);

  @override
  _SearchProductsState createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  final _getUserIdUseCase = Injector.appInstance.get<GetUserIdUseCase>();
  final _getProductsUseCase = Injector.appInstance.get<GetProductsUseCase>();
  
  TextEditingController _searchController = new TextEditingController();

  late String? _userId;

  late Stream<List<Product>> _listProductStream;
  List<Product> _listProducts = [];

  @override
  void initState() {
    _userId = _getUserIdUseCase.invoke();
    _listProductStream = _getProductsUseCase.invoke().asStream();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black50,
        toolbarHeight: 60.0,
        title: TextField(
          cursorColor: Colors.white,
          controller: _searchController,
          decoration: InputDecoration(
              hintText: " Busqueda",
              hintStyle: TextStyle(
                color: white,
                fontSize: 14.0
              ),
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                color: white,
                onPressed: () {
                  setState(() {
                    _listProducts = [];
                  });
                },
              )),
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
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
                _listProducts = productsUser(snapshot.data!);
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


  List<Product> productsUser(List<Product> products){
    for(int i = 0; i<products.length; i++){
      if(products[i].idUser!=_userId && products[i].name.toLowerCase().contains(_searchController.text)){
        _listProducts.add(products[i]);
      }
    }
    return _listProducts;
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
}

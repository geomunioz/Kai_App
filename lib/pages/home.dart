import 'package:app_eat/widgets/productCard.dart';
import 'package:flutter/material.dart';
import 'package:app_eat/widgets/colors.dart';
import 'package:app_eat/utils/strings.dart';
import 'package:app_eat/utils/routes.dart';

import 'package:app_eat/data/domain/user.dart';
import 'package:app_eat/data/domain/product.dart';
import 'package:app_eat/data/usecases/GetUserIdUseCase.dart';
import 'package:app_eat/data/usecases/GetUserListenerUseCase.dart';
import 'package:app_eat/data/usecases/GetProductsUseCase.dart';

import 'package:injector/injector.dart';

class HomePrincipal extends StatefulWidget {
  const HomePrincipal({Key? key}) : super(key: key);

  @override
  _HomePrincipalState createState() => _HomePrincipalState();
}

class _HomePrincipalState extends State<HomePrincipal> {
  final _getUserIdUseCase = Injector.appInstance.get<GetUserIdUseCase>();
  final _getUserListenerUseCase = Injector.appInstance.get<GetUserListenerUseCase>();
  final _getProductsUseCase = Injector.appInstance.get<GetProductsUseCase>();

  late Stream<User?> _getUser;
  late String? _userId;
  late User newUser;

  late Stream<List<Product>> _listProductStream;
  List<Product> _listProducts = [];

  @override
  void initState() {
    _userId = _getUserIdUseCase.invoke();
    _getUser = _getUserListenerUseCase.invoke(_userId!);

    _listProductStream = _getProductsUseCase.invoke().asStream();
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getArguments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        title: StreamBuilder<User?>(
          stream: _getUser,
          builder: (context, data){
            if (data.hasData && data.data != null) {
              return _userDataContainer(data.data!);
            }
            return const Text('Hola Name FirstName');
          },
        ),
        titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: black,
        automaticallyImplyLeading: false,
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
                _listProducts = productsNoUser(snapshot.data!);//snapshot.data!;
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
                            _nextScreen(productDetail_route, _listProducts[index]);
                          },
                      );
                  },
                );
              }
            }
        ),
      )
    );
  }

  void _getArguments() {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    if (args.isEmpty) {
      Navigator.pop(context);
      return;
    }
    newUser = args["user_args"];
  }

  Widget _userDataContainer(User user) {
    return Text(
      'Hola ${user.firstName}'
    );
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

  List<Product> productsNoUser(List<Product> products){
    for(int i = 0; i<products.length; i++){
      if(products[i].idUser!=_userId){
        _listProducts.add(products[i]);

      }
    }
    return _listProducts;
  }

  void _nextScreen(String route, Product product) {
    final args = {"product_args": product};
    Navigator.pushNamed(context, route, arguments: args);
  }
}

import 'package:app_eat/data/usecases/AddProductToCarUseCase.dart';
import 'package:app_eat/data/usecases/AddUserUseCase.dart';
import 'package:app_eat/data/usecases/GetUserUseCase.dart';
import 'package:app_eat/data/usecases/GetUserIdUseCase.dart';
import 'package:app_eat/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

import 'package:app_eat/data/domain/product.dart';
import 'package:app_eat/data/domain/user.dart';

import 'package:app_eat/data/usecases/GetUserListenerUseCase.dart';

import 'package:app_eat/widgets/colors.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _getUserListenerUseCase = Injector.appInstance.get<GetUserListenerUseCase>();
  final _getUserUseCase = Injector.appInstance.get<GetUserUseCase>();
  final _getUserIdUseCase = Injector.appInstance.get<GetUserIdUseCase>();
  final _addProductToCarUseCase = Injector.appInstance.get<AddProductToCarUseCase>();

  final _setUser = Injector.appInstance.get<AddUserUseCase>();

  late Stream<User?> _getUser; //User vendedor
  User? _getUserActual;
  late String? _userId;

  late Product newProduct;
  late User newUser;
  late String idProduct;
  int cant = 0;

  @override
  void initState() {
    super.initState();
    _userId = _getUserIdUseCase.invoke();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getArguments();
      setState(() {
        _getUser = _getUserListenerUseCase.invoke(newProduct.idUser);
      });
      _getUserFunction();
    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        title: StreamBuilder<User?>(
          stream: _getUser,
          builder: (context, data){
            if (data.hasData && data.data != null) {
              return _userDataContainer(data.data!);
            }
            return const Text('Name Seller');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(
              newProduct.urlImage,
              width: double.infinity,
              height: 200.0,
              fit: BoxFit.cover,
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                          child: Text(newProduct.quality,
                            style: TextStyle(
                              color: green100,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ),
                      Expanded(
                        child: Text(
                          '\$ ${newProduct.price.toString()}',
                          style: TextStyle(
                            color: green25,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.end,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                            newProduct.name,
                            style: TextStyle(
                              color: green50,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          newProduct.description,
                          style: TextStyle(
                            color: gray,
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.justify,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 16.0,
              bottom: 20.0,
              child: SizedBox(
                height: 49,
                child: FittedBox(
                  child: FloatingActionButton.extended(
                    backgroundColor: green50,
                    onPressed: (){
                      if(cant==0){
                        return;
                      }

                      _addProductShoopingCar();
                      _nextScreen(home_route);
                    },
                    label: Text(
                        'Añadir',
                      style: TextStyle(
                        color: black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
          ),
          Positioned(
            right: 116,
            bottom: 20,
            child: SizedBox(
              width: 56,
              height: 49,
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: green25,
                  onPressed: (){
                    if(cant>0){
                      setState(() {
                        cant--;
                      });
                    }
                  },
                  child: Icon(
                      Icons.arrow_back_ios,
                    color: black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 66,
            bottom: 20,
              child: SizedBox(
                width: 56,
                height: 49,
                child: FittedBox(
                  child: FloatingActionButton(
                    backgroundColor: black,
                    onPressed: (){},
                    child: Text(
                        '${cant}',
                      style: TextStyle(
                        color: green25,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
          ),
          Positioned(
            bottom: 20,
            right: 16,
            child: SizedBox(
              width: 56,
              height: 49,
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: green25,
                  onPressed: (){
                    if(cant<=newProduct.quantity){
                      setState(() {
                        cant++;
                      });
                    }
                  },
                  child: Icon(
                      Icons.arrow_forward_ios,
                    color: black,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _getArguments(){
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    if (args.isEmpty) {
      Navigator.pop(context);
      return;
    }
    newProduct = args["product_args"];
  }

  Widget _userDataContainer(User user) {
    return Text(
        '${user.firstName}'
    );
  }

  void _addProductShoopingCar(){
    List<Product> car = [];
    for(int i = 0; i<cant;i++){
      _addProductToCarUseCase.invoke(_userId!, newProduct);
    }
  }

  void _getUserFunction() async {
    String? userId = _getUserIdUseCase.invoke();

    if (userId == null) {
      Navigator.pop(context);
      return;
    }

    User? user = await _getUserUseCase.invoke(userId);

    if (user == null) {
      Navigator.pop(context);
      return;
    }

    _getUserActual = user;


    setState(() {

    });
  }

  void _nextScreen(String route) {
    Navigator.pushNamed(context, route);
  }
}

import 'package:app_eat/data/usecases/AddReservationUseCase.dart';
import 'package:app_eat/data/usecases/GetProductsCarUseCase.dart';
import 'package:app_eat/data/usecases/GetReservationUseCase.dart';
import 'package:app_eat/data/usecases/GetUserIdUseCase.dart';
import 'package:app_eat/data/usecases/RemoveCarUseCase.dart';
import 'package:app_eat/data/usecases/RemoveProductToCarUseCase.dart';
import 'package:app_eat/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:app_eat/widgets/colors.dart';
import 'package:app_eat/widgets/ShoppingCarProduct.dart';
import 'package:injector/injector.dart';
import 'package:app_eat/data/domain/product.dart';
import 'package:app_eat/utils/strings.dart';

class ShoppingCar extends StatefulWidget {
  const ShoppingCar({Key? key}) : super(key: key);

  @override
  _ShoppingCarState createState() => _ShoppingCarState();
}

class _ShoppingCarState extends State<ShoppingCar> {
  final _getUserIdUseCase = Injector.appInstance.get<GetUserIdUseCase>();
  final _getProductsCarUseCase = Injector.appInstance.get<GetProductsCarUseCase>();
  final _removeProductToCarUseCase = Injector.appInstance.get<RemoveProductToCarUseCase>();

  final _getReservationUseCase = Injector.appInstance.get<GetReservationUseCase>();
  final _addReservationUseCase = Injector.appInstance.get<AddReservationUseCase>();
  final _removeCarUseCase = Injector.appInstance.get<RemoveCarUseCase>();

  late Stream<List<Product>> _listProductStream;
  late Stream<List<Product>> _listProductTotalStream;
  List<Product> _listProducts = [];

  late String? _userId;
  late String? _reservationId;

  late double? totalPrice = 0.0;
  double subtotal = 0.0;

  @override
  void initState() {
    _userId = _getUserIdUseCase.invoke();

    _listProductStream = _getProductsCarUseCase.invoke(_userId!).asStream();
    _listProductTotalStream = _getProductsCarUseCase.invoke(_userId!).asStream();
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
        title: Text('Carrito'),
        titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: black,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                setState(() {
                  _listProducts.clear();
                  subtotal = 0;
                });
              },
              icon: Icon(Icons.refresh)
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<List<Product>>(
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
                _listProducts = productsCarUser(snapshot.data!);
                totalPrice = subtotal;
                return ListView.builder(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    itemCount: _listProducts.length,
                    itemBuilder: (BuildContext, int index){
                      return ShoppingCarProduct(
                        name: _listProducts[index].name,
                        urlImage: _listProducts[index].urlImage,
                        idUser: _listProducts[index].idUser,
                        price: _listProducts[index].price,
                        onTap: (){
                          _removeProductToCarUseCase.invoke(_userId!, _listProducts[index].id);
                          _listProductStream = _getProductsCarUseCase.invoke(_userId!).asStream();
                          setState(() {
                            _listProducts.clear();
                            subtotal = 0;
                          });
                        },
                      );
                    }
                );
              }
            }
        ),
      ),
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 30,
              right: 0,
              bottom:50,
              child: SizedBox(
                width: 200.0,
                height: 50.0,
                child: Container(
                  color: black,
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            child: Text('Total:',
                              style: TextStyle(
                                color: green100,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '\$ ${totalPrice!.toString()}',
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
                    ],
                  ),
                ),
              )
          ),
          Positioned(
            left: 32.0,
            bottom: 2.0,
            child: SizedBox(
              height: 49,
              child: FittedBox(
                child:MaterialButton(
                  minWidth: 326.0,
                  color: green50,
                  height: 49.0,
                  onPressed: (){
                    if(_listProducts.length==0){
                      return;
                    }
                   _reservationId =  _getReservationUseCase.invoke();
                   for(int i = 0; i< _listProducts.length; i++){
                     _addReservationUseCase.invoke(_reservationId!, _listProducts[i]);
                   }
                   _removeCarUseCase.invoke(_userId!);
                   _nextScreen(confirmReservation_route, _reservationId!);
                  },
                  child: Text('Reservar'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              ),
            ),
          ),
        ],
      ),
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

  List<Product> productsCarUser(List<Product> products){
    for(int i = 0; i<products.length; i++){
        _listProducts.add(products[i]);
        subtotal = subtotal + products[i].price;
    }
    return _listProducts;
  }

  void _nextScreen(String route, String reservationId) {
    final args = {"reservation_args": reservationId};
    Navigator.pushNamed(context, route, arguments: args);
  }

}

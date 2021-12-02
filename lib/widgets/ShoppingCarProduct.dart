import 'package:app_eat/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:app_eat/data/domain/user.dart';
import 'package:app_eat/data/usecases/GetUserListenerUseCase.dart';

class ShoppingCarProduct extends StatelessWidget {
  String name;
  String urlImage;
  String idUser;
  double price;
  Function() onTap;

  late Stream<User?> _getUser;

  ShoppingCarProduct(
      {Key? key,
        required this.name,
        required this.urlImage,
        required this.idUser,
        required this.price,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _getUserListenerUseCase = Injector.appInstance.get<GetUserListenerUseCase>();

    _getUser = _getUserListenerUseCase.invoke(idUser);

    return Card(
      color: black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Image(
              width: 70,
              height: 70,
              image: NetworkImage(urlImage),

            ),
            title: Text(
                name,
              style: TextStyle(
                color: green50
              ),
            ),
            subtitle: StreamBuilder<User?>(
              stream: _getUser,
              builder: (context, data){
                if (data.hasData && data.data != null) {
                  return _userDataContainer(data.data!);
                }
                return const Text('Name Seller');
              },
            ),
            trailing: IconButton(
              onPressed: onTap,
              icon: Icon(Icons.delete),
              color: gray,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 0, 20, 8),
            child: Text(
                '\$ ${price.toString()}',
              style: TextStyle(
                color: green25,
                fontSize: 16.0,
                fontWeight: FontWeight.w600
              ),
            ),
          )
        ],
      )
    );
  }

  Widget _userDataContainer(User user) {
    return Expanded(
        child: Container(
          child: Text(
            user.firstName,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: gray,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
    );
  }
}

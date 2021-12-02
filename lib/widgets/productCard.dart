import 'package:app_eat/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:app_eat/utils/routes.dart';

import 'package:app_eat/data/domain/user.dart';

import 'package:app_eat/data/usecases/GetUserListenerUseCase.dart';

import 'package:injector/injector.dart';

class ProductCard extends StatelessWidget {
  String name;
  String urlImage;
  String idUser;
  double price;
  Function() onTap;

  late Stream<User?> _getUser;

  ProductCard(
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        splashColor: green25,
        onTap: onTap,
          child: SizedBox(
            width: 130,
            height: 160,
            child: Column(
              children: <Widget>[
                Image.network(
                  urlImage.toString(),
                  width: double.infinity,
                  height: 90.0,
                  fit: BoxFit.cover,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(8, 5, 8, 2),
                            child: Text(
                              name,
                              style: TextStyle(
                                color: green50,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                            )
                          ),
                      ),

                    ]
                ),
               Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: <Widget>[
                     Expanded(
                       child: Container(
                         padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                         child: StreamBuilder<User?>(
                           stream: _getUser,
                           builder: (context, data){
                             if (data.hasData && data.data != null) {
                               return _userDataContainer(data.data!);
                             }
                             return const Text('Name Seller');
                           },
                         ),
                       ),
                     ),
                   ]
               ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                      child: Text(
                        '\$ ${price.toString()}',
                        style: TextStyle(
                          color: green25,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ),
    );
  }

  Widget _userDataContainer(User user) {
    return Text(
      user.firstName,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: gray,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

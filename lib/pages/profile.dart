import 'package:app_eat/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app_eat/widgets/colors.dart';

import 'package:app_eat/data/domain/user.dart';
import 'package:app_eat/data/usecases/GetUserIdUseCase.dart';
import 'package:app_eat/data/usecases/GetUserListenerUseCase.dart';
import 'package:app_eat/data/usecases/SignOutUseCase.dart';

import 'package:injector/injector.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _getUserIdUseCase = Injector.appInstance.get<GetUserIdUseCase>();
  final _getUserListenerUseCase =
      Injector.appInstance.get<GetUserListenerUseCase>();
  final _signOutUseCase = Injector.appInstance.get<SignOutUseCase>();

  late Stream<User?> _getUser;
  late Stream<User?> _getUserProfile;
  late String? _userId;
  late User newUser;

  @override
  void initState() {
    _userId = _getUserIdUseCase.invoke();
    _getUser = _getUserListenerUseCase.invoke(_userId!);
    _getUserProfile = _getUserListenerUseCase.invoke(_userId!);
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
        titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
        ),
        title: Text('Perfil'),
        backgroundColor: black,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<User?>(
                  stream: _getUserProfile,
                  builder: (context, data) {
                    if (data.hasData && data.data != null) {
                      return _userProfileContainer(data.data!);
                    }
                    return CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/profile_user.png'),
                      minRadius: 50,
                      maxRadius: 60,
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            StreamBuilder<User?>(
              stream: _getUser,
              builder: (context, data) {
                if (data.hasData && data.data != null) {
                  return _userDataContainer(data.data!);
                }
                return const Text('Hola Name FirstName');
              },
            ),
            SizedBox(
              height: 30.0,
            ),
            Card(
              color: black50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
              elevation: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      trailing: IconButton(
                        onPressed: () =>
                            _nextScreen(editProfile_route, newUser),
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: white,
                        ),
                      ),
                      title: Text(
                        'Editar Perfil',
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: Icon(
                        Icons.settings,
                        color: white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: black50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
              elevation: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      trailing: IconButton(
                        onPressed: () =>
                            _nextScreen(userProducts_route, newUser),
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: white,
                        ),
                      ),
                      title: Text(
                        'Productos',
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: Icon(
                        Icons.style_outlined,
                        color: white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /*Card(
              color: black50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
              elevation: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      trailing: IconButton(
                        onPressed: () =>
                            _nextScreen(orders_route, newUser),
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: white,
                        ),
                      ),
                      title: Text(
                        'Pedidos',
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: Icon(
                        Icons.receipt_long,
                        color: white,
                      ),
                    ),
                  ],
                ),
              ),
            ),*/
            Card(
              color: black50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
              elevation: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      trailing: IconButton(
                        onPressed: _signOut,
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: white,
                        ),
                      ),
                      title: Text(
                        'Cerrar Sesión',
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: Icon(
                        Icons.logout,
                        color: white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    ;
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
    newUser = user;
    return Text(
      '${user.firstName} ${user.lastName}',
      style: TextStyle(
        color: green25,
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
      ),
    );
  }

  Widget _userProfileContainer(User user) {
    return CircleAvatar(
      backgroundImage: NetworkImage(user.urlImage),
      minRadius: 50,
      maxRadius: 60,
    );
  }

  void _signOut() async {
    if (await _signOutUseCase.invoke()) {
      _nextScreen('/', newUser);
    }
  }

  void _nextScreen(String route, User user) {
    final args = {"user_args": user};
    Navigator.pushNamed(context, route, arguments: args);
  }
}

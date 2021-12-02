import 'package:flutter/material.dart';

import 'package:app_eat/widgets/colors.dart';
import 'package:app_eat/widgets/showAlertDialog.dart';
import 'package:app_eat/pages/homePages.dart';

import 'package:app_eat/data/usecases/GetUserUseCase.dart';
import 'package:app_eat/data/usecases/GetUserIdUseCase.dart';
import 'package:app_eat/data/usecases/SignInWithEmailUseCase.dart';
import 'package:app_eat/data/domain/user.dart';

import 'package:app_eat/utils/routes.dart';
import 'package:app_eat/utils/strings.dart';
import 'package:email_validator/email_validator.dart';
import 'package:injector/injector.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _getUserIdUseCase = Injector.appInstance.get<GetUserIdUseCase>();
  final _getUserUseCase = Injector.appInstance.get<GetUserUseCase>();
  final _signInWithEmailUseCase = Injector.appInstance.get<SignInWithEmailUseCase>();

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  User newUser = User(
    id: "",
    firstName: "",
    lastName: "",
    email: "",
    urlImage: "",
    shoppingCar: [],
  );

  String? _userId;

  @override
  void initState() {
    super.initState();
    _userId = _getUserIdUseCase.invoke();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _isLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    child: Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
              child: Text(
                'Correo Electronico',
                style: TextStyle(
                  color: green50,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextField(
                style: TextStyle(
                  color: green25,
                ),

                decoration: InputDecoration(
                  filled: true,
                    fillColor: black50,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: black50),
                    ),
                    hintText: 'usuario@example.com',
                    hintStyle: TextStyle(
                      color: gray,
                    ),
                ),
              controller: _emailController,
            ),
            SizedBox(
              height: 30.0,
            ),
            SizedBox(
              height: 25.0,
              child: Text(
                'Contraseña',
                style: TextStyle(
                  color: green50,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextField(
              style: TextStyle(
                color: green25,
              ),
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: black50,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: black50),
                ),
                hintText: '**********',
                hintStyle: TextStyle(
                  color: gray,
                ),
              ),
              controller: _passwordController,
            ),
            SizedBox(
              height: 145.0,
            ),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                  height: 50.0,
                  color: green50,
                  child: Text('Iniciar Sesión'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: (() {
                    _loginWithEmail();
                  }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _isLogin() async {
    var user = await _getUserUseCase.invoke(_userId!);
    if(user == null){
      return;
    }
    _nextScreen(homePages_route, user);
    /*_userRegistered(_userId!).then(
          (user) => user != null ? _nextScreen(home_route, user) : () {},
    );*/
  }

  void _loginWithEmail() async{
    if(_emailController.text.isEmpty ||
        _passwordController.text.isEmpty){
      _showAlertDialog(
          context, alert_title_error, alert_content_email_password);
      return;
    }

    if(!EmailValidator.validate(_emailController.text)){
      _showAlertDialog(
          context, alert_title_error, alert_content_not_valid_email);
      return;
    }

    var userId = await _signInWithEmailUseCase.invoke(_emailController.text, _passwordController.text);
    if(userId == null){
      _showAlertDialog(
          context, alert_title_error, alert_content_incorrect);
      return;
    }

    var usered = await _getUserUseCase.invoke(userId);
    if(usered == null){
      _showAlertDialog(context, alert_title_error,
          alert_content_not_registered);
      return;
    }

    _nextScreen(homePages_route, usered);
  }

  void _nextScreen(String route, User user) {
    final args = {"user_args": user};
    Navigator.pushNamed(context, route, arguments: args);
  }

  void _showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ShowAlertDialog(
          title: title,
          content: content,
        );
      },
    );
  }

  void _openPageHome({required BuildContext context, bool fullscreenDialog = false}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: fullscreenDialog,
          builder: (context) => HomePages(),
        )
    );
  }
}

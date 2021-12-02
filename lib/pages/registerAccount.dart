import 'package:flutter/material.dart';

import 'package:app_eat/data/usecases/GetUserUseCase.dart';
import 'package:app_eat/data/usecases/SignUpWithEmailUseCase.dart';
import 'package:app_eat/data/usecases/SignInWithEmailUseCase.dart';

import 'package:app_eat/data/domain/user.dart';

import 'package:app_eat/widgets/colors.dart';
import 'package:app_eat/utils/strings.dart';
import 'package:app_eat/utils/routes.dart';
import 'package:app_eat/widgets/showAlertDialog.dart';

import 'package:injector/injector.dart';
import 'package:email_validator/email_validator.dart';

import 'index.dart';

class RegisterAccount extends StatefulWidget {
  const RegisterAccount({Key? key}) : super(key: key);

  @override
  _RegisterAccountState createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {
  final _signInWithEmailUseCase = Injector.appInstance.get<SignInWithEmailUseCase>();
  final _signUpWithEmailUseCase = Injector.appInstance.get<SignUpWithEmailUseCase>();
  final _getUserUseCase = Injector.appInstance.get<GetUserUseCase>();

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _passwordConfirmController = new TextEditingController();

  User newUser = User(
    id: "",
    firstName: "",
    lastName: "",
    email: "",
    urlImage: "",
    shoppingCar: [],
  );

  @override
  void initState(){
    super.initState();
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
              padding: const EdgeInsets.only(top: 80.0),
              child: Center(
                child: Container(
                  width: 200,
                  height: 60,
                  child: Text(
                    'Crear Cuenta',
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
              height: 20.0,
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
              height: 20.0,
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
              height: 20.0,
            ),
            SizedBox(
              height: 25.0,
              child: Text(
                'Confirmar Contraseña',
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
              controller: _passwordConfirmController,
            ),
            SizedBox(
              height: 170.0,
            ),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                height: 50.0,
                color: green25,
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    color: green100,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                onPressed: () => _openPageHome(
                  context: context,
                  fullscreenDialog: true,),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                  height: 50.0,
                  color: green50,
                  child: Text('Siguiente'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: _finishRegister,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openPageHome({required BuildContext context, bool fullscreenDialog = false}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: fullscreenDialog,
          builder: (context) => Home(),
        )
    );
  }

  _finishRegister() async{
    if(_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _passwordConfirmController.text.isEmpty){
      _showAlertDialog(context, alert_title_error, alert_content_imcomplete);
      return;
    }

    if(!EmailValidator.validate(_emailController.text)){
      _showAlertDialog(
          context, alert_title_error, alert_content_not_valid_email);
      return;
    }

    if(_passwordController.text != _passwordConfirmController.text){
      _showAlertDialog(
          context, alert_title_error, alert_content_incorrect_password);
      return;
    }

    var idUser = await _signInWithEmailUseCase.invoke(_emailController.text.toString(),
        _passwordController.text.toString());
    if(idUser != null) {
      _nextScreen(
        registerAccount_2,
        _saveChange(
          _emailController.text.toString(),
          _passwordController.text.toString(),
          idUser.toString(),
        ),
      );
    }else{
      var idValue = await _signUpWithEmailUseCase.invoke(_emailController.text, _passwordController.text);
      if(idValue == null){
        _showAlertDialog(context, alert_title_error,
            alert_content_email_used);
        return;
      }

      _nextScreen(
        registerAccount_2,
        _saveChange(
          _emailController.text.toString(),
          _passwordController.text.toString(),
          idValue,
        ),
      );
    }

  }

  Future<String?> _signUpWithEmail(String email, String password) async {
    String? user = await _signUpWithEmailUseCase.invoke(email, password);
    return user;
  }

  User _saveChange(String email, String password, String id) {
    newUser.id = id;
    newUser.email = email;
    return newUser;
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

  void _nextScreen(String route, User user) {
    final args = {"user_args": user};
    Navigator.pushNamed(context, route, arguments: args);
  }

  Future<User?> _userRegistered(String id) async {
    User? user = await _getUserUseCase.invoke(id);
    return user;
  }
}

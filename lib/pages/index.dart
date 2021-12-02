import 'package:flutter/material.dart';
import 'package:app_eat/widgets/colors.dart';
import 'package:app_eat/pages/login.dart';
import 'package:app_eat/pages/registerAccount.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100.0,
            ),
            Image(
                image: AssetImage('assets/images/Order.png'),
                fit: BoxFit.cover,
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
                'Bienvenido',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Productos a tu alcance más cerca de ti. Registrate o Inicia Sesión para disfrutar.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.normal,

              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 150.0,
            ),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                height: 50.0,
                  color: green50,
                  child: Text('Crear cuenta'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: () => _openPageRegister(
                    context: context,
                    fullscreenDialog: true,),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                  height: 50.0,
                  color: green25,
                  child: Text(
                      'Iniciar Sesión',
                    style: TextStyle(
                      color: green100,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: () => _openPageLogin(
                    context: context,
                    fullscreenDialog: true,),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openPageLogin({required BuildContext context, bool fullscreenDialog = false}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: fullscreenDialog,
          builder: (context) => Login(),
        )
    );
  }

  void _openPageRegister({required BuildContext context, bool fullscreenDialog = false}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: fullscreenDialog,
          builder: (context) => RegisterAccount(),
        )
    );
  }
}

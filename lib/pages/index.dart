import 'package:app_eat/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:app_eat/widgets/colors.dart';
import 'package:app_eat/pages/login.dart';
import 'package:app_eat/pages/register_account.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SingleChildScrollView(
        padding: padding,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 100.0,
            ),
            const Image(
                image: AssetImage('assets/images/Order.png'),
                fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 40.0,
            ),
            const Text(
                'Bienvenido',
              style: text24White,
            ),
            Container(
              width: 300.0,
              height: 50.0,
              alignment: Alignment.center,
              child: const Text(
                'Productos a tu alcance más cerca de ti. Registrate o Inicia Sesión para disfrutar.',
                style: text14White,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 150.0,
            ),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                height: 50.0,
                  color: green50,
                  child: const Text('Crear cuenta'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: () => _openPageRegister(
                    context: context,
                    fullscreenDialog: true,),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                  height: 50.0,
                  color: green25,
                  child: const Text(
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
          builder: (context) => const Login(),
        )
    );
  }

  void _openPageRegister({required BuildContext context, bool fullscreenDialog = false}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: fullscreenDialog,
          builder: (context) => const RegisterAccount(),
        )
    );
  }
}

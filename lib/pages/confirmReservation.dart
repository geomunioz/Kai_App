import 'package:app_eat/utils/routes.dart';
import 'package:app_eat/widgets/colors.dart';
import 'package:flutter/material.dart';

class ConfirmReservation extends StatefulWidget {
  const ConfirmReservation({Key? key}) : super(key: key);

  @override
  _ConfirmReservationState createState() => _ConfirmReservationState();
}

class _ConfirmReservationState extends State<ConfirmReservation> {

  String? newReservation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getArguments();
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage('assets/images/SuccessIcon.png'),
            ),
            Text(
                'Reserva Exitosa',
              style: TextStyle(
                color: white,
                fontSize: 24.0,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Sus productos se han reservado correctamente, puede recogerlos con el codigo de reserva.',
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Codigo de reserva:',
              style: TextStyle(
                color: white,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            newReservation == null ? Text(
                '123456789',
              style: TextStyle(
                color: green50,
                fontWeight: FontWeight.w600,
                fontSize: 24.0,
              ),
            ) : Text(
              '${newReservation.toString()}',
              style: TextStyle(
                color: green50,
                fontWeight: FontWeight.w600,
                fontSize: 24.0,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
        width: double.infinity,
        height: 49.0,
        child: FloatingActionButton.extended(
          backgroundColor: green50,
          onPressed: (){
            _nextScreen(home_route);
          },
          label: Text(
              'Aceptar',
            style: TextStyle(
              color: black,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _nextScreen(String route) {
    Navigator.pushNamed(context, route);
  }

  void _getArguments() {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    if (args.isEmpty) {
      Navigator.pop(context);
      return;
    }
    newReservation = args["reservation_args"];
  }
}

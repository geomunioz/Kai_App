import 'package:app_eat/utils/routes.dart';
import 'package:app_eat/utils/strings.dart';
import 'package:app_eat/utils/styles.dart';

import 'package:flutter/material.dart';

import 'package:app_eat/data/usecases/AddUserUseCase.dart';
import 'package:app_eat/data/usecases/UploadFileUseCase.dart';
import 'package:app_eat/data/domain/user.dart';

import 'package:app_eat/widgets/showAlertDialog.dart';
import 'package:app_eat/widgets/colors.dart';
import 'package:flutter/services.dart';

import 'package:injector/injector.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegisterAccount_2 extends StatefulWidget {
  const RegisterAccount_2({Key? key}) : super(key: key);

  @override
  _RegisterAccount_2State createState() => _RegisterAccount_2State();
}

class _RegisterAccount_2State extends State<RegisterAccount_2> {
  final _addUserUseCase = Injector.appInstance.get<AddUserUseCase>();
  final _uploadFileUseCase = Injector.appInstance.get<UploadFileUseCase>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();

  late User newUser;

  File? image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getArguments();
      _autocomplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SingleChildScrollView(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 60,
                  child: Text(
                    'Crear Cuenta',
                    style: text24WhiteBold,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25.0,
              child: Text(
                'Nombre',
                style: text16Green50,
              ),
            ),
            TextField(
              style:const  TextStyle(
                color: green25,
              ),

              decoration: const InputDecoration(
                filled: true,
                fillColor: black50,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: black50),
                ),
                hintText: 'Nombre',
                hintStyle: TextStyle(
                  color: gray,
                ),
              ),
              controller: _nameController,
            ),
            sizedBox20,
            const SizedBox(
              height: 25.0,
              child: Text(
                'Apellidos',
                style: text16Green50,
              ),
            ),
            TextField(
              style: const TextStyle(
                color: green25,
              ),

              decoration: const InputDecoration(
                filled: true,
                fillColor: black50,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: black50),
                ),
                hintText: 'Apellidos',
                hintStyle: TextStyle(
                  color: gray,
                ),
              ),
              controller: _lastnameController,
            ),
            sizedBox20,
            const SizedBox(
              height: 25.0,
              child: Text(
                'Imagen de Perfil',
                style: text16Green50,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                options(context);
              },
              style: ElevatedButton.styleFrom(
                primary: green50,
              ),
              child: const Text(
                'Agregar Imagen',
                style: text14Black,
              ),
            ),
            //image == null ? const Center() : Image.file(image!),
            image != null ? Image.file(
                image!,
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ) : const Center(),
            const SizedBox(
              height: 150.0,
            ),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                height: 50.0,
                color: green50,
                child: const Text('Crear Cuenta'),
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

  void _autocomplete() {
    if (newUser.firstName.isNotEmpty) {
      _nameController.text = newUser.firstName.toString();
    }
    if (newUser.lastName.isNotEmpty) {
      _lastnameController.text = newUser.lastName.toString();
    }
  }


  void _getArguments() {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    if (args.isEmpty) {
      Navigator.pop(context);
      return;
    }
    newUser = args["user_args"];
  }

  void _finishRegister() async{
    if (_lastnameController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        image != null) {
      String url = await _uploadFileUseCase.invoke(image!);
      _saveChange(_nameController.text.toString(), _lastnameController.text.toString(), url);
      _addUser(newUser).then(
              (value) => {
            if(value){
              _nextScreen(login_route, newUser)
            }else{
              _showAlertDialog(context, alert_title_error,
                  alert_content_error_registration),
              Navigator.pushNamed(context, login_route),
            }
          }
      );
    } else {
      _showAlertDialog(context, alert_title_error, alert_content_imcomplete);
    }
  }

  User _saveChange(String firstName, String lastName, String url) {
    newUser.firstName = firstName;
    newUser.lastName = lastName;
    newUser.urlImage = url;
    return newUser;
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

  Future<bool> _addUser(User newUser) async {
    bool response = await _addUserUseCase.invoke(newUser);
    return response;
  }

  void options(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () => pickImage(ImageSource.camera),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1, color: gray))
                      ),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Tomar foto',
                              style: TextStyle(
                                  fontSize: 16.0),
                            ),
                          ),
                          Icon(Icons.camera_alt, color: green25,),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => pickImage(ImageSource.gallery),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1, color: gray))
                      ),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Elergir Foto',
                              style: TextStyle(
                                  fontSize: 16.0),
                            ),
                          ),
                          Icon(Icons.image, color: green25,),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: const BoxDecoration(
                        color: green50,
                      ),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Cancelar',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: white,
                              ),
                              textAlign: TextAlign.center,
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
        }
    );
  }

  Future selImage(op) async {
    var pickerFile;

    if (op == 1) {
      pickerFile = await picker.getImage(source: ImageSource.camera);
    } else {
      pickerFile = await picker.getImage(source: ImageSource.gallery);
    }

    setState(() {
      if (pickerFile != null) {
        image = File(pickerFile.path!);
      } else {
        print('No seleccionaste foto');
      }
    });

    Navigator.of(context).pop();
  }

  Future pickImage(ImageSource source) async{
    try{
      final image = await ImagePicker().pickImage(source: source);
      if(image == null) return;

      final imageTermporary = File(image.path);
      setState(() {
        this.image = imageTermporary;
      });
    }on PlatformException catch(e){
      print('Filed to pick Image $e');
    }
  }
}

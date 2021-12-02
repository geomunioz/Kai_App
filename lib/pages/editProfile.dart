import 'dart:io';

import 'package:app_eat/data/usecases/AddUserUseCase.dart';
import 'package:app_eat/utils/routes.dart';
import 'package:app_eat/widgets/colors.dart';

import 'package:app_eat/data/domain/user.dart';

import 'package:app_eat/data/usecases/GetUserListenerUseCase.dart';
import 'package:app_eat/data/usecases/GetUserIdUseCase.dart';

import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _getUserIdUseCase = Injector.appInstance.get<GetUserIdUseCase>();
  final _getUserListenerUseCase = Injector.appInstance.get<GetUserListenerUseCase>();
  final _addUserUseCase = Injector.appInstance.get<AddUserUseCase>();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _lastnameController = new TextEditingController();

  File? image;
  final picker = ImagePicker();

  late Stream<User?> _getUser;
  late String? _userId;
  late User newUser;

  @override
  void initState() {
    _userId = _getUserIdUseCase.invoke();
    _getUser = _getUserListenerUseCase.invoke(_userId!);
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _getArguments();
      _nameController.text = newUser.firstName.toString();
      _lastnameController.text = newUser.lastName.toString();
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        title: Text(
            'Editar Perfil',
            style: TextStyle(
              color: white,
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 25.0,
              child: Text(
                'Nombre de Usuario',
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
                hintText: 'nombre de usuario',
                hintStyle: TextStyle(
                  color: gray,
                ),
              ),
              controller: _nameController,
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 25.0,
              child: Text(
                'Apellidos',
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
                hintText: 'Apellidos',
                hintStyle: TextStyle(
                  color: gray,
                ),
              ),
              controller: _lastnameController,
            ),
            /*ElevatedButton(
                onPressed: (){
                  options(context);
                },
              style: ElevatedButton.styleFrom(
                primary: green50,
              ),
                child: Text(
                    'Cambiar Imagen',
                  style: TextStyle(
                    color: black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ),*/
            SizedBox(
              height: 20.0,
            ),
            image == null ? Center() : Image.file(image!)
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        width: double.infinity,
        child: FloatingActionButton.extended(
          backgroundColor: green50,
            onPressed: (){
              if(_nameController.text.isNotEmpty &&
                  _lastnameController.text.isNotEmpty){
                newUser.firstName = _nameController.text;
                newUser.lastName = _lastnameController.text;
                _addUserUseCase.invoke(newUser);

                /*_nextScreen(profile_route);*/
                Navigator.of(this.context).pop();
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            label: Text(
                'GUARDAR',
              style: TextStyle(
                color: black,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
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
    newUser = args["user_args"];
  }

  void options(context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      selImage(1);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1, color: gray))
                      ),
                      child: Row(
                        children: [
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
                    onTap: (){
                      selImage(2);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1, color: gray))
                      ),
                      child: Row(
                        children: [
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
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: green50,
                      ),
                      child: Row(
                        children: [
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
                          Icon(Icons.camera_alt, color: green25,),
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

  Future selImage(op) async{
    var pickerFile;

    if(op == 1){
      pickerFile = await picker.getImage(source: ImageSource.camera);
    }else{
      pickerFile = await picker.getImage(source: ImageSource.gallery);
    }

    setState(() {
      if(pickerFile!=null){
        image = File(pickerFile.path!);
      }else{
        print('No seleccionaste foto');
      }
    });

    Navigator.of(context).pop();
  }
}

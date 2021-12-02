import 'package:app_eat/data/domain/product.dart';
import 'package:app_eat/data/domain/user.dart';

import 'package:app_eat/data/usecases/AddProductUseCase.dart';
import 'package:app_eat/data/usecases/GetUserIdUseCase.dart';
import 'package:app_eat/data/usecases/GetUserListenerUseCase.dart';
import 'package:app_eat/data/usecases/UploadFileUseCase.dart';

import 'package:app_eat/utils/routes.dart';
import 'package:app_eat/utils/strings.dart';

import 'package:app_eat/widgets/colors.dart';
import 'package:app_eat/widgets/showAlertDialog.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:injector/injector.dart';
import 'dart:io';

class NewProduct extends StatefulWidget {
  const NewProduct({Key? key}) : super(key: key);

  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  final _getUserIdUseCase = Injector.appInstance.get<GetUserIdUseCase>();
  final _getUserListenerUseCase = Injector.appInstance.get<GetUserListenerUseCase>();

  final _addProductUseCase = Injector.appInstance.get<AddProductUseCase>();
  final _uploadFileUseCase = Injector.appInstance.get<UploadFileUseCase>();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _quantityController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();

  Product newProduct = Product(
    id: "",
    idUser: "",
    name: "",
    description: "",
    category: "",
    quality: "",
    quantity: 0,
    urlImage: "",
    price: 0.0,
  );

  String selectedValue = "Paquetes";
  String selectedQuality = "Fresco";

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        title: Text('Agregar Producto'),
        titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
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
                'Nombre del Producto',
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
                hintText: 'nombre de producto',
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
                'Descripción',
                style: TextStyle(
                  color: green50,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              style: TextStyle(
                color: green25,
              ),

              decoration: InputDecoration(
                filled: true,
                fillColor: black50,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: black50),
                ),
                hintText: 'Descripción del producto',
                hintStyle: TextStyle(
                  color: gray,
                ),
              ),
              controller: _descriptionController,
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 25.0,
              child: Text(
                'Categoria',
                style: TextStyle(
                  color: green50,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: black50,
              child: DropdownButton(
                  disabledHint: Text("Selecciona Categoria"),
                  dropdownColor: black50,
                  isExpanded: true,
                  style: styleSelectItem,
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  items: dropdownItems
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 25.0,
              child: Text(
                'Calidad',
                style: TextStyle(
                  color: green50,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              color: black50,
              child: DropdownButton(
                  borderRadius: BorderRadius.circular(20),
                  disabledHint: Text("Selecciona Calidad"),
                  dropdownColor: black50,
                  isExpanded: true,
                  style: styleSelectItem,
                  value: selectedQuality,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedQuality = newValue!;
                    });
                  },
                  items: dropdownItemsQuality
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 25.0,
              child: Text(
                'Cantidad disponible',
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
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: black50,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: black50),
                ),
                hintText: 'ejemplo: 1',
                hintStyle: TextStyle(
                  color: gray,
                ),
              ),
              controller: _quantityController,
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 25.0,
              child: Text(
                'Imagen de Producto',
                style: TextStyle(
                  color: green50,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                options(context);
              },
              style: ElevatedButton.styleFrom(
                primary: green50,
              ),
              child: Text(
                'Agregar Imagen',
                style: TextStyle(
                  color: black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            image == null ? Center() : Image.file(image!),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 25.0,
              child: Text(
                'Precio de Producto',
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
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: black50,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: black50),
                ),
                hintText: 'ejemplo: 150.0',
                hintStyle: TextStyle(
                  color: gray,
                ),
              ),
              controller: _priceController,
            ),
            SizedBox(
              height: 60.0,
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        width: double.infinity,
        child: FloatingActionButton.extended(
          backgroundColor: green50,
          onPressed: () {
            _createProduct();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          label: Text(
            'Agregar Producto',
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

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Paquetes"), value: "Paquetes"),
      DropdownMenuItem(child: Text("Gratis"), value: "Gratis"),
      DropdownMenuItem(child: Text("Frutas"), value: "Frutas"),
      DropdownMenuItem(child: Text("Verduras"), value: "Verduras"),
      DropdownMenuItem(child: Text("Carnes"), value: "Carnes"),
      DropdownMenuItem(child: Text("Postres"), value: "Postres"),
      DropdownMenuItem(child: Text("Bebidas"), value: "Bebidas"),
      DropdownMenuItem(
          child: Text("Alimentos Preparados"), value: "Alimentos Preparados"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItemsQuality {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Fresco"), value: "Fresco"),
      DropdownMenuItem(child: Text("Fresco-Maduro"), value: "Fresco-Maduro"),
      DropdownMenuItem(child: Text("Maduro"), value: "Maduro"),
    ];
    return menuItems;
  }

  TextStyle styleSelectItem = new TextStyle(
    color: gray,
  );

  void options(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      selImage(1);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1, color: gray))
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
                    onTap: () {
                      selImage(2);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1, color: gray))
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
                    onTap: () {
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

    Navigator.of(this.context).pop();
  }

  void _createProduct() async{
    if (_nameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _quantityController.text.isEmpty ||
        image == null ||
        _priceController.text.isEmpty) {
      _showAlertDialog(this.context, alert_title_error, alert_content_imcomplete);
      return;
    }
    String url = await _uploadFileUseCase.invoke(image!);
    _saveChange(_userId!, _nameController.text, _descriptionController.text, selectedValue, selectedQuality, int.parse(_quantityController.text), url, double.parse(_priceController.text));
    bool value = await _addProductUseCase.invoke(newProduct);
    if(value == false){
      _showAlertDialog(this.context, alert_title_error,
          alert_content_error_registration);
      return;
    }
    /*_nextScreen(userProducts_route);*/
    Navigator.of(this.context).pop();
  }

  String basename(String path) => context.basename(path);

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

  Product _saveChange(String idUser, String name,
      String description, String category, String quality,
      int quantity, String urlImage, double price,) {
    newProduct.idUser = idUser;
    newProduct.name = name;
    newProduct.description = description;
    newProduct.category = category;
    newProduct.quality = quality;
    newProduct.quantity = quantity;
    newProduct.urlImage = urlImage;
    newProduct.price = price;

    return newProduct;
  }

  void _nextScreen(String route) {
    Navigator.pushNamed(this.context, route);
  }

  void _getArguments() {
    final args = ModalRoute.of(this.context)?.settings.arguments as Map;
    if (args.isEmpty) {
      Navigator.pop(this.context);
      return;
    }
    newUser = args["user_args"];
  }
}

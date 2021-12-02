import 'dart:io';
import 'package:app_eat/data/repositories/ProductsRepository.dart';

class UploadFileUseCase{
  final ProductsRepository productsRepository;

  UploadFileUseCase({required this.productsRepository});

  Future<String> invoke(File _image){
    return productsRepository.uploadFile(_image);
  }
}
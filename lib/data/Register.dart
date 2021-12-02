import 'package:app_eat/data/usecases/AddProductToCarUseCase.dart';
import 'package:app_eat/data/usecases/AddReservationUseCase.dart';
import 'package:app_eat/data/usecases/GetProductsCarUseCase.dart';
import 'package:app_eat/data/usecases/GetReservationUseCase.dart';
import 'package:app_eat/data/usecases/RemoveCarUseCase.dart';
import 'package:app_eat/data/usecases/RemoveProductToCarUseCase.dart';
import 'package:injector/injector.dart';

import 'package:app_eat/data/datasources/UserDataSource.dart';
import 'package:app_eat/data/datasources/AuthDataSource.dart';
import 'package:app_eat/data/datasources/ProductsDataSource.dart';

import 'package:app_eat/data/framework/Firebase/FirebaseUserDataSource.dart';
import 'package:app_eat/data/framework/Firebase/FirebaseAuthDataSource.dart';
import 'package:app_eat/data/framework/Firebase/FirebaseProductsDataSource.dart';

import 'package:app_eat/data/repositories/UserRepository.dart';
import 'package:app_eat/data/repositories/AuthRepository.dart';
import 'package:app_eat/data/repositories/ProductsRepository.dart';

import 'package:app_eat/data/usecases/AddUserUseCase.dart';
import 'package:app_eat/data/usecases/AddProductUseCase.dart';
import 'package:app_eat/data/usecases/GetProductUseCase.dart';
import 'package:app_eat/data/usecases/GetProductsUseCase.dart';
import 'package:app_eat/data/usecases/GetUserIdUseCase.dart';
import 'package:app_eat/data/usecases/GetUserUseCase.dart';
import 'package:app_eat/data/usecases/SignInWithEmailUseCase.dart';
import 'package:app_eat/data/usecases/SignOutUseCase.dart';
import 'package:app_eat/data/usecases/SignUpWithEmailUseCase.dart';
import 'package:app_eat/data/usecases/GetUserListenerUseCase.dart';
import 'package:app_eat/data/usecases/UploadFileUseCase.dart';
import 'package:app_eat/data/usecases/UpdateUserUseCase.dart';

class Register{
  static void regist(){
    final injector = Injector.appInstance;

    /**Data Sources**/
    injector.registerDependency<AuthDataSource>(() => FirebaseAuthDataSource());

    injector.registerDependency<ProductsDataSource>(() => FirebaseProductsDataSource());

    injector.registerDependency<UserDataSource>(() => FirebaseUserDataSource());

    /**Repositories**/
    injector.registerDependency<AuthRepository>(
            () => AuthRepository(authDataSource: injector.get<AuthDataSource>()));

    injector.registerDependency<ProductsRepository>(() =>
        ProductsRepository(productsDataSource: injector.get<ProductsDataSource>()));


    injector.registerDependency<UserRepository>(
            () => UserRepository(userDataSource: injector.get<UserDataSource>()));

    /**Use Case**/
    injector.registerDependency<AddProductUseCase>(
            () => AddProductUseCase(productsRepository: injector.get<ProductsRepository>()));

    injector.registerDependency<AddProductToCarUseCase>(
            () => AddProductToCarUseCase(userRepository: injector.get<UserRepository>()));
    
    injector.registerDependency<AddReservationUseCase>(
            () => AddReservationUseCase(userRepository: injector.get<UserRepository>()));
    

    injector.registerDependency<AddUserUseCase>(
            () => AddUserUseCase(userRepository: injector.get<UserRepository>()));

    injector.registerDependency<GetProductsCarUseCase>(
            () => GetProductsCarUseCase(userRepository: injector.get<UserRepository>()));

    injector.registerDependency<GetProductUseCase>(
            () => GetProductUseCase(productsRepository: injector.get<ProductsRepository>()));

    injector.registerDependency<GetProductsUseCase>(
            () => GetProductsUseCase(productsRepository: injector.get<ProductsRepository>()));
    
    injector.registerDependency(
            () => GetReservationUseCase(userRepository: injector.get<UserRepository>()));

    injector.registerDependency<GetUserIdUseCase>(
            () => GetUserIdUseCase(authRepository: injector.get<AuthRepository>()));

    injector.registerDependency<GetUserUseCase>(
            () => GetUserUseCase(userRepository: injector.get<UserRepository>()));

    injector.registerDependency<GetUserListenerUseCase>(() =>
        GetUserListenerUseCase(userRepository: injector.get<UserRepository>()));

    injector.registerDependency<RemoveProductToCarUseCase>(() =>
        RemoveProductToCarUseCase(userRepository: injector.get<UserRepository>()));

    injector.registerDependency<RemoveCarUseCase>(() =>
        RemoveCarUseCase(userRepository: injector.get<UserRepository>()));

    injector.registerDependency<SignInWithEmailUseCase>(() =>
        SignInWithEmailUseCase(authRepository: injector.get<AuthRepository>()));

    injector.registerDependency<SignOutUseCase>(
            () => SignOutUseCase(authRepository: injector.get<AuthRepository>()));

    injector.registerDependency<SignUpWithEmailUseCase>(() =>
        SignUpWithEmailUseCase(authRepository: injector.get<AuthRepository>()));

    injector.registerDependency<UploadFileUseCase>(() =>
        UploadFileUseCase(productsRepository: injector.get<ProductsRepository>()));

    injector.registerDependency<UpdateUserUseCase>(() =>
        UpdateUserUseCase(userRepository: injector.get<UserRepository>()));

  }
}
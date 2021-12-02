import 'package:app_eat/pages/categoryProducts.dart';
import 'package:app_eat/pages/confirmReservation.dart';
import 'package:app_eat/pages/newProduct.dart';
import 'package:app_eat/pages/orders.dart';
import 'package:app_eat/pages/profile.dart';
import 'package:app_eat/pages/searchProducts.dart';
import 'package:app_eat/pages/userProducts.dart';
import 'package:flutter/material.dart';

import 'package:app_eat/pages/homePages.dart';
import 'package:app_eat/pages/login.dart';
import 'package:app_eat/pages/registerAccount_2.dart';
import 'package:app_eat/pages/editProfile.dart';
import 'package:app_eat/pages/productDetails.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    home_route: (BuildContext context) => HomePages(),
    login_route: (BuildContext context) => Login(),
    registerAccount_2: (BuildContext context) => RegisterAccount_2(),
    homePages_route: (BuildContext context) => HomePages(),
    editProfile_route: (BuildContext context) => EditProfile(),
    productDetail_route: (BuildContext context) => ProductDetails(),
    userProducts_route: (BuildContext context) => UserProducts(),
    newProduct_route: (BuildContext context) => NewProduct(),
    categoryProduct_route: (BuildContext context) => CategoryProducts(),
    searchProducts_route: (BuildContext context) => SearchProducts(),
    confirmReservation_route: (BuildContext context) => ConfirmReservation(),
    orders_route: (BuildContext context) => Orders(),
    profile_route: (BuildContext context) => Profile(),
  };
}

const home_route = 'home';
const login_route = 'login';
const registerAccount_2 = 'registerAccount_2';
const homePages_route = 'homePage';

const editProfile_route = 'editProfile';
const productDetail_route = 'productDetail';
const userProducts_route = 'userProducts';
const newProduct_route = 'newProduct';
const categoryProduct_route = 'categoryProduct';
const searchProducts_route = 'searchProducts';
const confirmReservation_route = 'confirmReservation';
const orders_route = 'orders';
const profile_route = 'profile';
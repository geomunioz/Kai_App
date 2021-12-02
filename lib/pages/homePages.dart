import 'package:app_eat/widgets/colors.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'search.dart';
import 'shoopingCar.dart';
import 'profile.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int _currentIndex = 0;
  List _listPages = [];
  late Widget _currentPage;

  @override
  void initState(){
    super.initState();

    _listPages
      ..add(HomePrincipal())
      ..add(Search())
      ..add(ShoppingCar())
      ..add(Profile());
      

    _currentPage = HomePrincipal();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Center(
          child: _currentPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: green50,
        selectedItemColor: black,
        unselectedItemColor: black50,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        iconSize: 30.0,

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Busqueda',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag),
              label: 'Carrito',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (selectedIndex) => _changePage(selectedIndex),
      ),
    );
  }

  void _changePage(int selectedIndex){
    setState(() {
      _currentIndex = selectedIndex;
      _currentPage = _listPages[selectedIndex];
    });
  }
}

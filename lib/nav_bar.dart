import 'package:eCommerce/account.dart';
import 'package:eCommerce/favorites.dart';
import 'package:eCommerce/home.dart';
import 'package:flutter/material.dart';

class PageNavigator extends StatefulWidget {
  const PageNavigator({super.key});

  @override
  State<PageNavigator> createState() => _PageNavigatorState();
}

class _PageNavigatorState extends State<PageNavigator> {
  int _currentIndex = 0;
  var _selectedColor = const Color.fromARGB(255, 111, 165, 246);

  final List<Widget> _pages = [
    homepage(),
    const Favorites(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            switch (index) {
              case 0:
                _selectedColor = const Color.fromARGB(255, 111, 165, 246);
                break;
              case 1:
                _selectedColor = const Color.fromRGBO(209, 52, 51, 1);
                break;
              case 2:
                _selectedColor = const Color.fromRGBO(15, 34, 165, 1);
            }
          });
        },
        unselectedItemColor: const Color.fromARGB(255, 85, 115, 130),
        selectedItemColor: _selectedColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        iconSize: 34,
        elevation: 5,
      ),
    );
  }
}

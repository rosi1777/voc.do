import 'package:flutter/material.dart';
import 'package:todo_dafault/common/theme.dart';

import '../history_view.dart';
import '../home_view.dart';
import '../profile_view.dart';

class BottomNavbar extends StatefulWidget {
  static String routeName = '/bottom_navbar';
  const BottomNavbar({super.key});
  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  List _pages = [];

  @override
  void initState() {
    _pages = [const HomeView(), const HistoryView(), const ProfileView()];
    super.initState();
  }

  int _selectedPage = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPage] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: navbar,
        selectedItemColor: blue,
        selectedLabelStyle: TextStyle(color: blue),
        unselectedLabelStyle: TextStyle(color: navItem),
        unselectedItemColor: navItem,
        onTap: _selectPage,
        currentIndex: _selectedPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        ],
      ),
    );
  }
}

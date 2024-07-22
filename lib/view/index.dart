import 'package:flutter/material.dart';
import 'package:proyecto_moviles/view/auth/config.dart';
import 'package:proyecto_moviles/view/laboratorios.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  static const List<Widget> _menuContent = [Laboratorios(), Configuration()];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _menuContent[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings), label: 'Ajustes')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 37, 17, 188),
        onTap: _onItemTapped,
      ),
    );
  }
}

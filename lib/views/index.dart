import 'package:flutter/material.dart';
import 'package:proyecto_moviles/views/auth/settings.dart';
import 'package:proyecto_moviles/views/laboratorios.dart';

class IndexPages extends StatefulWidget {
  const IndexPages({super.key});

  @override
  State<IndexPages> createState() => _IndexPagesState();
}

class _IndexPagesState extends State<IndexPages> {
  static const List<Widget> _menuContent = [Laboratorios(), Settings()];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyecto Moviles'),
        centerTitle: true,
        
      ),
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
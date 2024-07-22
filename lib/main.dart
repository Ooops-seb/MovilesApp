import 'package:flutter/material.dart';
import 'package:proyecto_moviles/view/agendar.dart';
import 'package:proyecto_moviles/view/horarios.dart';
import 'package:proyecto_moviles/view/laboratorios.dart';
import 'package:proyecto_moviles/view/scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 223, 27, 144)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'GRUPO #3'),
      routes: {
        '/laboratorios': (context) => Laboratorios(),
        '/horarios': (context) => Horarios(),
        '/agendar': (context) => Agendar(),
        '/scanner': (context) => scanner(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const List<Widget> _content2 = [
    Laboratorios(), // pagina de inicio
  ];

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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: _content2[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.smartphone), label: 'API')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 37, 17, 188),
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 140, 128, 235)),
              child: Text(
                'Menu de Opciones',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Laboratorios'),
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.stay_current_landscape),
              title: Text('API'),
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:proyecto_moviles/view/agendar.dart';
import 'package:proyecto_moviles/view/auth/index.dart';
import 'package:proyecto_moviles/view/horarios.dart';
import 'package:proyecto_moviles/view/laboratorios.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Proyecto Móviles',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AuthIndex(),
      ),
    );
  }
}

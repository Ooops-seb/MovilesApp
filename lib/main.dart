import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_moviles/providers/auth_provider.dart';
import 'package:proyecto_moviles/view/agendar.dart';
import 'package:proyecto_moviles/view/auth/index.dart';
import 'package:proyecto_moviles/view/horarios.dart';
import 'package:proyecto_moviles/view/index.dart';
import 'package:proyecto_moviles/view/laboratorios.dart';
import 'package:proyecto_moviles/view/scanner.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCiYtEFl56iUBSrA1RByLE1OEP19TtZB4E',
          appId: '1:147565314523:android:0399ad82e9aeca9fa967fe',
          messagingSenderId: 'proyecto-moviles-espe',
          projectId: 'proyecto-moviles-espe',
          storageBucket: 'proyecto-moviles-espe.appspot.com'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthyProvider())
      ],
      child: MaterialApp(
        title: 'Proyecto Móviles',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 223, 27, 144)),
          useMaterial3: true,
        ),
        home: Consumer<AuthyProvider> (
          builder: (_ , authProvider, __){
            return authProvider.isAuthenticated ? const IndexPage() : const AuthIndex();
          },
        ),
        routes: {
          '/laboratorios': (context) => const Laboratorios(),
          '/horarios': (context) => const Horarios(),
          '/agendar': (context) => const Agendar(),
          '/scanner': (context) => const scanner(),
        },
      ),
    );
  }
}
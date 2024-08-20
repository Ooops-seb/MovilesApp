import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_moviles/providers/AuthProvider.dart';
import 'package:proyecto_moviles/providers/UserProvider.dart';
import 'package:proyecto_moviles/views/agendar.dart';
import 'package:proyecto_moviles/views/auth/loading.dart';
import 'package:proyecto_moviles/views/horarios.dart';
import 'package:proyecto_moviles/views/laboratorios.dart';
import 'package:proyecto_moviles/views/scanner.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:proyecto_moviles/utils/firebase_options.dart';

Future<void> main() async {
  await dotenv.load(fileName: './.env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          create: (context) =>
              UserProvider(Provider.of<AuthProvider>(context, listen: false)),
          update: (context, authProvider, previousUserProvider) {
            return UserProvider(authProvider);
          },
        ),
      ],
      child: MaterialApp(
        title: 'Proyecto Móviles',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 223, 27, 144)),
          useMaterial3: true,
        ),
        home: const LoadingScreen(),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_moviles/providers/AuthProvider.dart';

class AuthIndex extends StatefulWidget {
  const AuthIndex({super.key});

  @override
  State<AuthIndex> createState() => _AuthIndexState();
}

class _AuthIndexState extends State<AuthIndex> {
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
        body: Center(
            child: Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Image(
            image: AssetImage('assets/images/logo.png'),
            width: 150,
          ),
          const Column(
            children: [
              Text(
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  'Inicio de Sesión'),
              Text(
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                  'Ingresa con tu correo institucional'),
            ],
          ),
          FilledButton(
              onPressed: (() async {
                authProvider.signIn();
              }),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      image: AssetImage('assets/icons/google.png'),
                      width: 20,
                    ),
                    Padding(padding: EdgeInsets.all(6)),
                    Text('Iniciar Sesión')
                  ],
                ),
              )),
          const Text(
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
              'Móviles - 16829')
        ],
      ),
    )));
  }
}

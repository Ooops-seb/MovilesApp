// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:proyecto_moviles/view/index.dart';

class AuthIndex extends StatefulWidget {
  const AuthIndex({super.key});

  @override
  State<AuthIndex> createState() => _AuthIndexState();
}

class _AuthIndexState extends State<AuthIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
      padding: EdgeInsets.only(top: 60, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
            image: AssetImage('assets/images/logo.png'),
            width: 150,
          ),
          Column(
            children: [
              const Text(
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  'Inicio de Sesión'),
              const Text(
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey),
                  'Ingresa con tu correo institucional'),
            ],
          ),
          FilledButton(
              onPressed: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => IndexPage()));
              }),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Image(
                      image: AssetImage('assets/icons/google.png'),
                      width: 20,
                    ),
                    Padding(padding: EdgeInsets.all(6)),
                    const Text('Iniciar Sesión')
                  ],
                ),
              )),
          const Text(
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey),
              'Móviles - 16829')
        ],
      ),
    )));
  }
}

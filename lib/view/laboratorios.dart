import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class Laboratorios extends StatefulWidget {
  const Laboratorios({super.key});

  @override
  State<Laboratorios> createState() => _LaboratoriosState();
}

class _LaboratoriosState extends State<Laboratorios> {
  @override
  Widget build(BuildContext context) {
    final AuthyProvider authyProvider = Provider.of<AuthyProvider>(context);

    return FutureBuilder<User?>(
        future: Future.delayed(Duration.zero, () => authyProvider.getUser()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox.square(
                  dimension: 50.0, child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasData) {
            return Scaffold(
                body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  snapshot.data?.photoURL != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage(snapshot.data?.photoURL! ?? ''),
                        )
                      : const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/user.jpg'),
                        ),
                  const SizedBox(height: 10),
                  Text(
                    'Bienvenido, ${snapshot.data?.displayName ?? 'Usuario'}!',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Laboratorios SW',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/horarios');
                    },
                    child: const Text(
                      'Visualizar horarios',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/agendar');
                    },
                    child: const Text(
                      'Agendar Laboratorio',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/scanner');
                    },
                    child: const Text(
                      'Escanear QR',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ));
          } else {
            return const Text('Sin conexion');
          }
        });
  }
}

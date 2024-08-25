import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_moviles/providers/UserProvider.dart';

class Laboratorios extends StatefulWidget {
  const Laboratorios({super.key});

  @override
  State<Laboratorios> createState() => _LaboratoriosState();
}

class _LaboratoriosState extends State<Laboratorios> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        return Scaffold(
            body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(userProvider.imageUrl ?? ''),
              ),
              const SizedBox(height: 10),
              Text(
                'Bienvenido, ${userProvider.fullName}!',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Laboratorios SW',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/horarios');
                },
                child: const Text(
                  'Visualizar horarios',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/agendar');
                },
                child: const Text(
                  'Agendar Laboratorio',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/scanner');
                },
                child: const Text(
                  'Escanear QR',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ));
      }
    );
  }
}

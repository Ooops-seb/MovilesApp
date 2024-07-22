import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Foto de Perfil',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Padding(padding: EdgeInsets.all(5)),
            Center(
              child: const CircleAvatar(
                radius: 70,
                backgroundImage:
                    AssetImage('assets/images/logo.png'), // foto de perfil
              ),
            ),
            TextButton(onPressed: () {}, child: Text('Editar')),
            const Padding(padding: EdgeInsets.all(10)),
            Column(
              children: [
                TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Otro campo',
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Otro campo',
                  ),
                )
              ],
            ),
            const Padding(padding: EdgeInsets.all(10)),
            FilledButton(onPressed: () {}, child: Text('Guardar'))
          ],
        ),
      ),
    );
  }
}

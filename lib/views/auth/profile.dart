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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Foto de Perfil',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                const Center(
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage:
                        AssetImage('assets/images/user.jpg'), // foto de perfil
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text('Editar')),
                const Padding(padding: EdgeInsets.all(10)),
                const Column(
                  children: [
                    TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Otro campo',
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Otro campo',
                      ),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.all(10)),
                FilledButton(onPressed: () {}, child: const Text('Guardar'))
              ],
            ),
          ),
        ));
  }
}

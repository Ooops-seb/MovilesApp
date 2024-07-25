import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_moviles/providers/auth_provider.dart';
import 'package:proyecto_moviles/view/auth/config.dart';
import 'package:proyecto_moviles/view/auth/profile.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    final AuthyProvider authyProvider = Provider.of<AuthyProvider>(context);
    return FutureBuilder<User?>(
      future: Future.delayed(Duration.zero, () => authyProvider.getUser()), 
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: SizedBox.square(
                dimension: 50.0, child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajustes',
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
        padding:
            const EdgeInsets.only(top: 60, bottom: 10, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
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
              snapshot.data?.displayName ?? 'Nombre Apellido',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              snapshot.data?.email ??'email@domain.com',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Profile()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Configuration()));
              },
            ),
          ],
        ),
      ),
    );
        } else {
          return const Text('Conexion perdida');
        }
      }
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_moviles/components/loading.dart';
import 'dart:async';
import 'package:proyecto_moviles/providers/AuthProvider.dart';
import 'package:proyecto_moviles/providers/UserProvider.dart';
import 'package:proyecto_moviles/views/auth/config.dart';
import 'package:proyecto_moviles/views/auth/loading.dart';
import 'package:proyecto_moviles/views/auth/profile.dart';
import 'package:proyecto_moviles/views/auth/settings.dart';
import 'package:proyecto_moviles/views/laboratorios.dart';

class IndexPages extends StatefulWidget {
  const IndexPages({super.key});

  @override
  State<IndexPages> createState() => _IndexPagesState();
}

class _IndexPagesState extends State<IndexPages> {
  static const List<Widget> _userMenuContent = [
    Laboratorios(),
    Profile(),
  ];
  static const List<Widget> _actionsMenuContent = [Configuration(), Settings()];

  int _selectedIndex = 0;

  void _onDrawerItemTapped(int index, bool isEndDrawer) {
    Navigator.pop(context);

    if (isEndDrawer) {
      if (index < _userMenuContent.length) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => _userMenuContent[index]),
        );
      }
    } else {
      if (index < _userMenuContent.length) {
        setState(() {
          _selectedIndex = index;
        });
      } else {
        final contentIndex = index - _userMenuContent.length;
        if (contentIndex < _actionsMenuContent.length) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => _actionsMenuContent[contentIndex]),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.imageUrl == null || userProvider.fullName == null) {
        return const LoadingComponent();
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text('Proyecto Móviles'),
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  icon: CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(userProvider.imageUrl ?? ''),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                );
              },
            ),
          ],
        ),
        endDrawer: NavigationDrawer(
          children: [
            DrawerHeader(
                child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(userProvider.imageUrl ?? ''),
                ),
                const SizedBox(height: 20),
                Text(
                  'Bienvenido, ${userProvider.fullName}!',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil de usuario'),
              onTap: () {
                _onDrawerItemTapped(1, true);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                _showMyDialog(context);
              },
            ),
          ],
        ),
        drawer: NavigationDrawer(
          children: [
            const DrawerHeader(
                child: Center(
              child: Text(
                'Configuración',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            )),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Ajustes generales'),
              onTap: () {
                _onDrawerItemTapped(2, false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Seguridad'),
              onTap: () {
                _onDrawerItemTapped(3, false);
              },
            ),
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _userMenuContent + _actionsMenuContent,
        ),
      );
    });
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  final AuthProvider authProvider =
      Provider.of<AuthProvider>(context, listen: false);
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Atención',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('¿Estás seguro de cerrar sesión?'),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Sí'),
            onPressed: () async {
              await authProvider.signOut();
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoadingScreen()),
              );
            },
          ),
        ],
      );
    },
  );
}

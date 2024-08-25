import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_moviles/components/loading.dart';
import 'dart:async';
import 'package:proyecto_moviles/providers/AuthProvider.dart';
import 'package:proyecto_moviles/providers/UserProvider.dart';
import 'package:proyecto_moviles/views/agendar.dart';
import 'package:proyecto_moviles/views/auth/loading.dart';
import 'package:proyecto_moviles/views/auth/profile.dart';
import 'package:proyecto_moviles/views/home.dart';
import 'package:proyecto_moviles/views/horarios.dart';
import 'package:proyecto_moviles/views/laboratorios/laboratorios.dart';
import 'dart:developer' as developer;

import 'package:proyecto_moviles/views/scanner.dart';

class IndexPages extends StatefulWidget {
  const IndexPages({super.key});

  @override
  State<IndexPages> createState() => _IndexPagesState();
}

class _IndexPagesState extends State<IndexPages> {
  static const List<Widget> _userMenuContent = [
    HomePage(),
    Profile(), //1
  ];
  static const List<Widget> _actionsMenuContent = [
    Horarios(), //2
    ListaLaboratorios(), //3
    Agendar() //4
  ];

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
      developer.log(userProvider.role.toString());
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
                'Profesor',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Ver',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ListTile(
                    leading: const Icon(Icons.book_outlined),
                    title: const Text('Horarios'),
                    onTap: () {
                      _onDrawerItemTapped(2, false);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.layers_outlined),
                    title: const Text('Laboratorios'),
                    onTap: () {
                      _onDrawerItemTapped(3, false);
                    },
                  ),
                  Divider()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Reservación',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ListTile(
                    leading: const Icon(Icons.bookmark_add_outlined),
                    title: const Text('Crear Reserva'),
                    onTap: () {
                      _onDrawerItemTapped(4, false);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.bookmarks_outlined),
                    title: const Text('Ver Reservas'),
                    onTap: () {
                      _onDrawerItemTapped(4, false);
                    },
                  ),
                  Divider()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Cursos',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ListTile(
                    leading: const Icon(Icons.school_outlined),
                    title: const Text('Mis Cursos'),
                    onTap: () {
                      _onDrawerItemTapped(4, false);
                    },
                  ),
                  Divider()
                ],
              ),
            ),
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _userMenuContent + _actionsMenuContent,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Scanner()),
            );
          },
          child: const Icon(Icons.qr_code_scanner),
          tooltip: 'Leer QR',
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

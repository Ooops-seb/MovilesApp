import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_moviles/providers/auth_provider.dart';

class Configuration extends StatefulWidget {
  const Configuration({super.key});

  @override
  State<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Configuración',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.red),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.abc_sharp),
                title: const Text(
                  'Opción 1',
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.abc_sharp),
                title: const Text(
                  'Opción 2',
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.abc_sharp),
                title: const Text(
                  'Opción 3',
                ),
                onTap: () {},
              ),
              const Divider(),
              const Padding(padding: EdgeInsets.all(4)),
              const Center(
                child: Text(
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                    'Zona de Peligro'),
              ),
              const Padding(padding: EdgeInsets.all(4)),
              FilledButton(
                  onPressed: (() {
                    _showMyDialog(context);
                  }),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [Text('Cerrar Sesión', style: TextStyle(fontWeight: FontWeight.bold))],
                    ),
                  )),
            ],
          ),
        ));
  }

  Future<void> _showMyDialog(BuildContext context) async {
    final AuthyProvider authyProvider = Provider.of<AuthyProvider>(context, listen: false);
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atención', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('¿Estas seguro de cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Si'),
              onPressed: () async {
                await authyProvider.signOut();
              },
            ),
          ],
        );
      },
    );
  }
}

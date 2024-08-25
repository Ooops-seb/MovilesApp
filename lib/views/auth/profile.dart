import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_moviles/components/loading.dart';
import 'package:proyecto_moviles/enums/role.dart';
import 'package:proyecto_moviles/providers/UserProvider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _roleController;
  late TextEditingController _createdAtController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _roleController = TextEditingController();
    _createdAtController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    _createdAtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (userProvider.email == null ||
          userProvider.fullName == null ||
          userProvider.imageUrl == null) {
        return const LoadingComponent();
      }

      final fullName = userProvider.fullName ?? 'Desconocido';
      final email = userProvider.email ?? 'Desconocido';
      final imageUrl = userProvider.imageUrl ?? '';
      final role = roleEnumValues[roleEnumFromString[userProvider.role!] ?? 'Desconocido'] ?? 'Desconocido';
      final createdAt = DateTimeFormat.format(userProvider.createdAt ?? DateTime.now(), format: DateTimeFormats.european);

      // Update controllers with user data
      _nameController.text = fullName;
      _emailController.text = email;
      _roleController.text = role;
      _createdAtController.text = createdAt;

      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Perfil',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                const Text(
                  'Foto de Perfil',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(20)),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: _nameController,
                        enabled: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nombre Completo',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: _emailController,
                        enabled: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: _roleController,
                        enabled: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Rol',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: _createdAtController,
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Creado En',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

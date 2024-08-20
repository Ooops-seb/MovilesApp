import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_moviles/providers/AuthProvider.dart';
import 'package:proyecto_moviles/providers/UserProvider.dart';
import 'package:proyecto_moviles/views/auth/index.dart';
import 'package:proyecto_moviles/views/index.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        if (authProvider.isAuthenticated == true) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            final userProvider =
                Provider.of<UserProvider>(context, listen: false);
            await userProvider.loadUserData();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const IndexPages()),
            );
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return const AuthIndex();
        }
      },
    );
  }
}

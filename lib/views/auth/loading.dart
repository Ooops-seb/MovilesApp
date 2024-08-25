import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_moviles/components/loading.dart';
import 'package:proyecto_moviles/providers/AuthProvider.dart';
import 'package:proyecto_moviles/providers/UserProvider.dart';
import 'package:proyecto_moviles/views/auth/index.dart';
import 'package:proyecto_moviles/views/index.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        if (authProvider.isAuthenticated == true) {
          return Consumer<UserProvider>(
            builder: (context, userProvider, _) {
              if (userProvider.id == null) {
                return const LoadingComponent();
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const IndexPages()),
                  );
                });
                return const Scaffold(
                  body: LoadingComponent(),
                );
              }
            },
          );
        } else {
          return const AuthIndex();
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:async';

class LoadingComponent extends StatefulWidget {
  const LoadingComponent({super.key});

  @override
  State<LoadingComponent> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoadingComponent> {
  int _currentMessageIndex = 0;
  final List<String> _loadingMessages = [
    "Estamos cargando tus datos...",
    "Por favor espera un momento...",
    "Preparando tu experiencia..."
  ];

  @override
  void initState() {
    super.initState();
    _startMessageRotation();
  }

  void _startMessageRotation() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        setState(() {
          _currentMessageIndex =
              (_currentMessageIndex + 1) % _loadingMessages.length;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text(_loadingMessages[_currentMessageIndex]),
          ],
        ),
      ),
    );;
  }
}
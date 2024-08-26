import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:proyecto_moviles/components/loading.dart';
import 'package:proyecto_moviles/services/Laboratory.dart';

class QrViewer extends StatefulWidget {
  final String labId;

  QrViewer({required this.labId});

  @override
  _QrViewerState createState() => _QrViewerState();
}

class _QrViewerState extends State<QrViewer> {
  Uint8List? _qrCode;
  bool _isLoading = true;
  final LaboratoryService _laboratoryService = LaboratoryService();

  @override
  void initState() {
    super.initState();
    _loadQrCode();
  }

  Future<void> _loadQrCode() async {
    Uint8List? qrCode = await _laboratoryService.downloadQrCode(widget.labId);
    setState(() {
      _qrCode = qrCode;
      _isLoading = false;
    });
  }

  Future<void> _downloadQrCode() async {
    if (_qrCode == null) return;
    if (await Permission.storage.isGranted) {
      await _saveQrCode();
    } else {
      final permissionStatus = await Permission.storage.request();

      if (permissionStatus.isGranted) {
        await _saveQrCode();
      } else if (permissionStatus.isDenied) {
        _showPermissionDeniedMessage('Permiso de almacenamiento denegado');
      } else if (permissionStatus.isPermanentlyDenied) {
        _showPermissionDeniedMessage('Permiso de almacenamiento denegado permanentemente.');
        await openAppSettings();
      }
    }
  }

  Future<void> _saveQrCode() async {
    final directory = await getExternalStorageDirectory();
    final filePath = '${directory!.path}/${widget.labId}.png';

    final file = File(filePath);
    await file.writeAsBytes(_qrCode!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('QR Code descargado en $filePath')),
    );
  }

  void _showPermissionDeniedMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Viewer'),
      ),
      body: Center(
        child: _isLoading
            ? const LoadingComponent()
            : _qrCode != null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.memory(_qrCode!),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _downloadQrCode,
              icon: const Icon(Icons.download),
              label: const Text('Descargar QR'),
            ),
          ],
        )
            : const Text('Failed to load QR code'),
      ),
    );
  }
}

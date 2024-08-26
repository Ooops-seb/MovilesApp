import 'package:flutter/material.dart';
import 'package:proyecto_moviles/views/laboratorios/laboratorio.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? qrText;
  bool isCameraActive = false;
  bool isPermissionDenied = false;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;

    if (status.isGranted) {
      setState(() {
        isCameraActive = true;
      });
    } else if (status.isDenied || status.isPermanentlyDenied) {
      if (await Permission.camera.request().isGranted) {
        setState(() {
          isCameraActive = true;
          isPermissionDenied = false;
        });
      } else {
        setState(() {
          isPermissionDenied = true;
          isCameraActive = false;
        });
      }
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData.code;
      });

      if (qrText != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Laboratorio(id: qrText!),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Scanner',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (isCameraActive)
            Expanded(
              flex: 4,
              child: QRView(
                overlayMargin: const EdgeInsets.all(20),
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            )
          else if (isPermissionDenied)
            Expanded(
              flex: 4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.camera_alt_outlined,
                      size: 100,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Acceso a la cámara denegado.\nHabilita los permisos desde la configuración.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        openAppSettings();
                      },
                      child: const Text('Abrir Configuración'),
                    ),
                  ],
                ),
              ),
            )
          else
            const Expanded(
              flex: 4,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          const Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Por favor escanea el QR del laboratorio a visualizar',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

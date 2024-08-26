import 'package:flutter/material.dart';
import 'package:proyecto_moviles/components/loading.dart';
import 'package:proyecto_moviles/models/Laboratory.dart';
import 'package:proyecto_moviles/services/Laboratory.dart';
import 'package:proyecto_moviles/views/agenda/agendar.dart';

class Laboratorio extends StatefulWidget {
  final String id;
  const Laboratorio({required this.id, Key? key}) : super(key: key);

  @override
  State<Laboratorio> createState() => _LaboratorioState();
}

class _LaboratorioState extends State<Laboratorio> {
  Laboratory? _laboratory;
  bool isLoading = true;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    if (!isLoaded) {
      loadLaboratory();
    }
  }

  Future<void> loadLaboratory() async {
    LaboratoryService service = LaboratoryService();
    var laboratory = await service.getLaboratory(widget.id);

    if (mounted) {
      setState(() {
        _laboratory = laboratory;
        isLoading = false;
        isLoaded = true;
      });
    }
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
        title: const Text(
          'Información de Laboratorio',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Agendar(userId: widget.id)),
          );
        },
        child: const Icon(Icons.bookmark_add_outlined),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const LoadingComponent()
            : (_laboratory == null)
                ? const Center(child: Text('No se encontraron datos.'))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          child: Column(
                            children: [
                              Text(
                                _laboratory!.name,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'ID: ${_laboratory!.id}',
                                style: const TextStyle(
                                    fontSize: 8, fontWeight: FontWeight.w500, color: Colors.grey),
                              ),
                              const SizedBox(height: 20),
                              Column(
                                children: [
                                  const Text('Información: ', style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text(_laboratory!.info ?? ''),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      Container(
                          child: Column(
                        children: [
                          const Center(
                            child: Text(
                              'Horarios',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
      ),
    );
  }
}

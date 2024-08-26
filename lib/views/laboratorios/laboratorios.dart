import 'package:flutter/material.dart';
import 'package:proyecto_moviles/components/loading.dart';
import 'package:proyecto_moviles/models/Laboratory.dart';
import 'package:proyecto_moviles/services/Laboratory.dart';

import 'package:proyecto_moviles/views/laboratorios/laboratorio.dart';

class ListaLaboratorios extends StatefulWidget {
  const ListaLaboratorios({super.key});

  @override
  State<ListaLaboratorios> createState() => _ListaLaboratoriosState();
}

class _ListaLaboratoriosState extends State<ListaLaboratorios> {
  List<Laboratory>? _laboratoryList;
  bool isLoading = true;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    if (!isLoaded) {
      loadLaboratories();
    }
  }

  Future<void> loadLaboratories() async {
    LaboratoryService _service = LaboratoryService();
    var laboratories = await _service.getLaboratories();

    if (mounted) {
      setState(() {
        _laboratoryList = laboratories;
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
          'Laboratorios',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: isLoading
            ? const Center(
                child: LoadingComponent(),
              )
            : _laboratoryList == null || _laboratoryList!.isEmpty
                ? const Center(
                    child: Text('No existen datos.'),
                  )
                : RefreshIndicator(
                    displacement: 20.0,
                    onRefresh: () async {
                      setState(() {
                        isLoading = true;
                        _laboratoryList = null;
                      });
                      await loadLaboratories();
                    },
                    child: ListView(
                      children: _laboratoryList!.map((lab) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          lab.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.visible,
                                        ),
                                      ),
                                      Text(
                                        'ID: ${lab.id}',
                                        style: const TextStyle(
                                            fontSize: 8, fontWeight: FontWeight.w500, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        const Text(
                                          'Información: ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          lab.info ?? 'No info',
                                          style: const TextStyle(fontSize: 12),
                                          overflow: TextOverflow.visible,
                                        ),
                                      ],
                                    ),
                                  )
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Laboratorio(id: lab.id),
                                        ),
                                      );
                                    },
                                    child: const Text('Ver Detalles'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
      ),
    );
  }
}

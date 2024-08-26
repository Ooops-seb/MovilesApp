import 'package:flutter/material.dart';
import 'package:proyecto_moviles/components/loading.dart';
import 'package:proyecto_moviles/models/Course.dart';
import 'package:proyecto_moviles/services/Course.dart';

class ListaCursos extends StatefulWidget {
  final String userId;
  const ListaCursos({required this.userId, Key? key}) : super(key: key);

  @override
  State<ListaCursos> createState() => _ListaCursosState();
}

class _ListaCursosState extends State<ListaCursos> {
  List<Course>? _courseList;
  bool isLoading = true;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    if (!isLoaded) {
      loadCourses();
    }
  }

  Future<void> loadCourses() async {
    CourseService _service = CourseService();
    var courses = await _service.getUserCourses(widget.userId);

    if (mounted) {
      setState(() {
        _courseList = courses;
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
          'Mis Cursos',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: isLoading
            ? const Center(
                child: const LoadingComponent(),
              )
            : _courseList == null || _courseList!.isEmpty
                ? const Center(
                    child: Text('No existen datos.'),
                  )
                : RefreshIndicator(
                    displacement: 20.0,
                    onRefresh: () async {
                      setState(() {
                        isLoading = true;
                        _courseList = null;
                      });
                      await loadCourses();
                    },
                    child: ListView(
                      children: _courseList!.map((course) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          course.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'NRC: ${course.id}',
                                          style: const TextStyle(
                                              fontSize: 8, fontWeight: FontWeight.w500, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  )
                                ),
                                const Divider(),
                                Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          const Text(
                                            'Información: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            course.info,
                                            overflow: TextOverflow.visible,
                                          )
                                        ],
                                      )
                                    ],
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

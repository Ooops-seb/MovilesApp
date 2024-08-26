import 'package:flutter/material.dart';
import 'package:proyecto_moviles/components/loading.dart';
import 'package:proyecto_moviles/enums/days.dart';
import 'package:proyecto_moviles/enums/hours.dart';
import 'package:proyecto_moviles/enums/status.dart';
import 'package:proyecto_moviles/enums/type.dart';
import 'package:proyecto_moviles/models/Booking.dart';
import 'package:proyecto_moviles/models/Course.dart';
import 'package:proyecto_moviles/models/Laboratory.dart';
import 'package:proyecto_moviles/models/Schedule.dart';
import 'package:proyecto_moviles/services/Booking.dart';
import 'package:proyecto_moviles/services/Course.dart';
import 'package:proyecto_moviles/services/Laboratory.dart';
import 'package:proyecto_moviles/services/Schedule.dart';
import 'package:proyecto_moviles/views/agenda/agenda.dart';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:proyecto_moviles/views/auth/loading.dart';

class Agendar extends StatefulWidget {
  final String userId;
  const Agendar({required this.userId});

  @override
  State<Agendar> createState() => _AgendarState();
}

class _AgendarState extends State<Agendar> {
  final _formKey = GlobalKey<FormState>();
  List<Course> _userCourses = [];
  List<Laboratory> _laboratories = [];
  List<Schedule> _schedules = [];
  TypeEnum? _selectedType;
  DayEnum? _selectedDay;
  Course? _selectedCourse;
  Laboratory? _selectedLaboratory;
  Schedule? _selectedSchedule;
  String? _info;
  bool _isLoading = true;
  bool _isSubmitting = false;
  List<DayEnum> _selectedDays = [];
  List<HoursEnum> _selectedHours = [];
  List<ScheduleDetail> _scheduleDetails = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.wait(
        [_fetchUserCourses(), _fetchLaboratories(), _fetchSchedules()]);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _fetchUserCourses() async {
    CourseService courseService = CourseService();
    var courses = await courseService.getUserCourses(widget.userId);
    if (courses != null) {
      setState(() {
        _userCourses = courses;
      });
    }
  }

  List<CheckboxListTile> _buildDayCheckboxes() {
    return DayEnum.values.map((day) {
      return CheckboxListTile(
        title: Text(dayEnumValues[day]!),
        value: _selectedDays.contains(day),
        onChanged: (bool? value) {
          setState(() {
            if (value == true) {
              _selectedDays.add(day);
            } else {
              _selectedDays.remove(day);
            }
          });
        },
      );
    }).toList();
  }

  List<CheckboxListTile> _buildHourCheckboxes() {
    return HoursEnum.values.map((hour) {
      return CheckboxListTile(
        title: Text(hoursEnumValues[hour]!),
        value: _selectedHours.contains(hour),
        onChanged: (bool? value) {
          setState(() {
            if (value == true) {
              _selectedHours.add(hour);
            } else {
              _selectedHours.remove(hour);
            }
          });
        },
      );
    }).toList();
  }

  Future<void> _fetchLaboratories() async {
    LaboratoryService labService = LaboratoryService();
    var labs = await labService.getLaboratories();
    if (labs != null) {
      setState(() {
        _laboratories = labs;
      });
    }
  }

  Future<void> _fetchSchedules() async {
    ScheduleService scheduleService = ScheduleService();
    var schedules = await scheduleService.getSchedules();
    if (schedules != null) {
      setState(() {
        _schedules = schedules;
      });
    }
  }

  Future<void> _createScheduleAndBooking() async {
    setState(() {
      _isSubmitting = true; // Mostrar el LoadingComponent
    });

    final random = Random();
    int randomNumber = random.nextInt(999999999);
    var _id = randomNumber;

    final newSchedule = Schedule(
      id: _id,
      detail: _selectedDays.map((day) {
        return ScheduleDetail(
          day: day,
          hours: _selectedHours.isNotEmpty ? _selectedHours.first : HoursEnum.hora_7_00_9_00,
        );
      }).toList(),
    );

    try {
      final scheduleId = await ScheduleService().sendScheduleToApi(newSchedule);

      if (scheduleId != null) {
        final booking = Booking(
          id: _id,
          date: DateTime.now(),
          courseId: _selectedCourse!.id,
          labId: _selectedLaboratory!.id,
          scheduleId: _id,
          type: _selectedType!,
          state: StatusEnum.pendiente,
          info: _info,
        );

        final response = await BookingService().sendBookingToApi(booking);
        if (response != null) {
          developer.log(response.toJson().toString());
          if (widget.userId.isNotEmpty) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoadingScreen()),
            );
          }else {
            developer.log('El usuario en la reserva es null.');
          }
        }
      }
    } catch (e) {
      developer.log('Error al crear Schedule o Booking: $e');
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservar Laboratorio'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: LoadingComponent())
          : _isSubmitting
          ? const Center(child: LoadingComponent())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Selecciona Curso', style: TextStyle(fontSize: 12)),
                DropdownButtonFormField<Course>(
                  items: _userCourses.map((Course course) {
                    return DropdownMenuItem<Course>(
                      value: course,
                      child: Text(course.name, style: const TextStyle(fontSize: 12)),
                    );
                  }).toList(),
                  onChanged: (Course? newValue) {
                    setState(() {
                      _selectedCourse = newValue;
                    });
                  },
                  validator: (value) => value == null ? 'Selecciona un curso' : null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.school),
                    hintText: 'Curso',
                    hintStyle: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Selecciona Laboratorio', style: TextStyle(fontSize: 12)),
                DropdownButtonFormField<Laboratory>(
                  items: _laboratories.map((Laboratory lab) {
                    return DropdownMenuItem<Laboratory>(
                      value: lab,
                      child: Text(lab.name, style: const TextStyle(fontSize: 12)),
                    );
                  }).toList(),
                  onChanged: (Laboratory? newValue) {
                    setState(() {
                      _selectedLaboratory = newValue;
                    });
                  },
                  validator: (value) => value == null ? 'Selecciona un laboratorio' : null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.science),
                    hintText: 'Laboratorio',
                    hintStyle: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Selecciona Día(s)', style: TextStyle(fontSize: 12)),
                ..._buildDayCheckboxes(),
                const SizedBox(height: 16),
                const Text('Selecciona Hora(s)', style: TextStyle(fontSize: 12)),
                ..._buildHourCheckboxes(),
                const SizedBox(height: 16),
                const Text('Selecciona Tipo de Reserva', style: TextStyle(fontSize: 12)),
                DropdownButtonFormField<TypeEnum>(
                  items: TypeEnum.values.map((TypeEnum type) {
                    return DropdownMenuItem<TypeEnum>(
                      value: type,
                      child: Text(typeEnumValues[type]!, style: const TextStyle(fontSize: 12)),
                    );
                  }).toList(),
                  onChanged: (TypeEnum? newValue) {
                    setState(() {
                      _selectedType = newValue;
                    });
                  },
                  validator: (value) => value == null ? 'Selecciona un tipo de reserva' : null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.category),
                    hintText: 'Tipo de Reserva',
                    hintStyle: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Información Adicional (Opcional)', style: TextStyle(fontSize: 12)),
                TextFormField(
                  maxLines: 3,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.info),
                    hintText: 'Información adicional...',
                    hintStyle: TextStyle(fontSize: 12),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _info = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _createScheduleAndBooking();
                    }
                  },
                  child: const Text('Reservar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

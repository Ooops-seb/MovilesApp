import 'package:date_time_format/date_time_format.dart';
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
import 'package:proyecto_moviles/models/User.dart';
import 'package:proyecto_moviles/services/Booking.dart';
import 'package:proyecto_moviles/services/Course.dart';
import 'package:proyecto_moviles/services/Laboratory.dart';
import 'package:proyecto_moviles/services/Schedule.dart';
import 'package:proyecto_moviles/services/User.dart';

class ListadoAgenda extends StatefulWidget {
  const ListadoAgenda({super.key});

  @override
  State<ListadoAgenda> createState() => _ListadoAgendaState();
}

class _ListadoAgendaState extends State<ListadoAgenda> {
  List<Booking>? _bookingList;
  bool isLoading = true;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    if (!isLoaded) {
      loadBookings();
    }
  }

  final Map<StatusEnum, IconData> _statusIcons = {
    StatusEnum.aprobado: Icons.check_circle,
    StatusEnum.rechazado: Icons.cancel,
    StatusEnum.pendiente: Icons.pending,
  };

  Future<void> loadBookings() async {
    BookingService _bookingService = BookingService();
    LaboratoryService _laboratoryService = LaboratoryService();
    CourseService _courseService = CourseService();
    UserService _userService = UserService();
    ScheduleService _scheduleService = ScheduleService();

    var bookings = await _bookingService.getBookings();

    if (bookings != null) {
      for (var booking in bookings) {
        booking.laboratory =
            await _laboratoryService.getLaboratory(booking.labId);
        booking.course =
            await _courseService.getCourse(booking.courseId.toString());
        booking.user = await _userService.getUserById(booking.course!.userId);
        booking.schedule =
            await _scheduleService.getSchedule(booking.scheduleId.toString());
      }
    }

    if (mounted) {
      setState(() {
        _bookingList = bookings;
        isLoading = false;
        isLoaded = true;
      });
    }
  }

  Widget _buildStatusLegend() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: StatusEnum.values.map((status) {
          return Row(
            children: [
              Icon(
                _statusIcons[status],
                color: status == StatusEnum.aprobado
                    ? Colors.green
                    : status == StatusEnum.rechazado
                        ? Colors.red
                        : Colors.orange,
                size: 16,
              ),
              const SizedBox(width: 5),
              Text(
                status.toString().split('.').last,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          );
        }).toList(),
      ),
    );
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
          'Agenda',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            _buildStatusLegend(),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: LoadingComponent(),
                    )
                  : _bookingList == null || _bookingList!.isEmpty
                      ? const Center(
                          child: Text('No existen datos.'),
                        )
                      : RefreshIndicator(
                          displacement: 20.0,
                          onRefresh: () async {
                            setState(() {
                              isLoading = true;
                              _bookingList = null;
                            });
                            await loadBookings();
                          },
                          child: ListView(
                            children: _bookingList!.map((booking) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        _statusIcons[booking.state],
                                        color: _statusIcons[booking.state] ==
                                                Icons.check_circle
                                            ? Colors.green
                                            : _statusIcons[booking.state] ==
                                                    Icons.cancel
                                                ? Colors.red
                                                : Colors.orange,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Mostrar detalles del laboratorio, usuario, etc.
                                            Text(
                                              booking.laboratory?.name ??
                                                  'Nombre Laboratorio',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.visible,
                                            ),
                                            const Divider(),
                                            const Center(
                                              child: Text(
                                                'Horarios',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            if (booking.schedule != null)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: booking
                                                    .schedule!.detail
                                                    .map((detail) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 5),
                                                    child: Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'Día: ',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              dayEnumValues[
                                                                  detail.day]!,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Row(
                                                          children: [
                                                            const Text(
                                                              'Hora: ',
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Text(
                                                              hoursEnumValues[
                                                                  detail
                                                                      .hours]!,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            const Divider(),
                                            const Center(
                                              child: Text(
                                                'Curso',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Docente: ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  booking.user!.fullName,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'NRC: ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  booking.courseId.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Curso: ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    booking.course!.name,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                    overflow:
                                                        TextOverflow.visible,
                                                    softWrap: true,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Divider(),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Tipo de Reserva: ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  typeEnumValues[booking.type]!,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Observaciones: ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    booking.info ?? 'No info',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                    overflow:
                                                        TextOverflow.visible,
                                                    softWrap: true,
                                                  ),
                                                ),
                                              ],
                                            ),
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
          ],
        ),
      ),
    );
  }
}

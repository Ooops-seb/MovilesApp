import 'package:flutter/material.dart';
import 'package:proyecto_moviles/components/loading.dart';
import 'package:proyecto_moviles/enums/days.dart';
import 'package:proyecto_moviles/enums/hours.dart';
import 'package:proyecto_moviles/enums/status.dart';
import 'package:proyecto_moviles/enums/type.dart';
import 'package:proyecto_moviles/models/Booking.dart';
import 'package:proyecto_moviles/models/Laboratory.dart';
import 'package:proyecto_moviles/services/Booking.dart';
import 'package:proyecto_moviles/services/Course.dart';
import 'package:proyecto_moviles/services/Laboratory.dart';
import 'package:proyecto_moviles/services/Schedule.dart';
import 'package:proyecto_moviles/services/User.dart';
import 'package:proyecto_moviles/views/agenda/agendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Laboratorio extends StatefulWidget {
  final String id;
  const Laboratorio({required this.id, Key? key}) : super(key: key);

  @override
  State<Laboratorio> createState() => _LaboratorioState();
}

class _LaboratorioState extends State<Laboratorio> {
  List<Booking>? _bookingList;
  Laboratory? _laboratory;
  bool isLoading = true;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    if (!isLoaded) {
      loadBookingsAndLaboratory();
    }
  }

  final Map<StatusEnum, IconData> _statusIcons = {
    StatusEnum.aprobado: Icons.check_circle,
    StatusEnum.rechazado: Icons.cancel,
    StatusEnum.pendiente: Icons.pending,
  };

  Future<void> loadBookingsAndLaboratory() async {
    BookingService _bookingService = BookingService();
    LaboratoryService _laboratoryService = LaboratoryService();
    CourseService _courseService = CourseService();
    UserService _userService = UserService();
    ScheduleService _scheduleService = ScheduleService();

    var laboratory = await _laboratoryService.getLaboratory(widget.id);

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

      bookings =
          bookings.where((booking) => booking.labId == widget.id).toList();
    }

    if (mounted) {
      setState(() {
        _laboratory = laboratory;
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

  Widget _buildLaboratoryInfo() {
    return _laboratory == null
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _laboratory!.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                _laboratory!.info ?? 'No hay información disponible',
                style: const TextStyle(fontSize: 16),
              ),
              const Divider(
                height: 40,
                thickness: 1,
              ),
            ],
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
          'Laboratorio',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Descargar QR',
            onPressed: () {
              if (!isLoading) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Descargando QR...')));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Se estan cargando tus datos...')));
              }
            },
            icon: isLoading ? const FaIcon(FontAwesomeIcons.gears) : const Icon(Icons.qr_code),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!isLoading) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Agendar(userId: widget.id)),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Se estan cargando tus datos...')));
          }
        },
        child: const Icon(Icons.bookmark_add_outlined),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            _buildLaboratoryInfo(),
            const Padding(
              padding: EdgeInsets.all(15),
              child: Center(
                child: Text(
                  'Horarios Reservados',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            _buildStatusLegend(),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: LoadingComponent(),
                    )
                  : _bookingList == null || _bookingList!.isEmpty
                      ? const Center(
                          child: Text(
                              'No existen reservas para este laboratorio.'),
                        )
                      : RefreshIndicator(
                          displacement: 20.0,
                          onRefresh: () async {
                            setState(() {
                              isLoading = true;
                              _bookingList = null;
                            });
                            await loadBookingsAndLaboratory();
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

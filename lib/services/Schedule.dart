import 'dart:convert';
import 'package:proyecto_moviles/utils/api.dart';
import 'package:proyecto_moviles/models/Schedule.dart';
import 'dart:developer' as developer;

class ScheduleService {
  ScheduleService();

  final ApiConsumer api = ApiConsumer();
  final _endPoint = 'schedules';

  Future<Schedule?> getSchedule(String? id) async {
    try {
      final endPoint = '$_endPoint/$id';
      var response = await api.GET(endPoint);

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          developer.log('El cuerpo de la respuesta está vacío.');
          return null;
        } else {
          try {
            Map<String, dynamic> responseBody = jsonDecode(response.body);
            var laboratory = Schedule.fromJson(responseBody);
            return laboratory;
          } catch (e) {
            developer.log('Error al decodificar JSON: $e');
            return null;
          }
        }
      } else {
        developer.log('Error al enviar solicitud: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      developer.log('Error de conexión: $e');
      return null;
    }
  }

  Future<List<Schedule>?> getSchedules() async {
    List<Schedule> result = [];
    try {
      final endPoint = '$_endPoint';
      var response = await api.GET(endPoint);

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          developer.log('El cuerpo de la respuesta está vacío.');
          return result;
        } else {
          try {
            List<dynamic> listBody = jsonDecode(response.body);
            for (var item in listBody) {
              var laboratory = Schedule.fromJson(item);
              result.add(laboratory);
            }
          } catch (e) {
            developer.log('Error al decodificar JSON: $e');
            return result;
          }
        }
      } else {
        developer.log('Error al enviar usuario: ${response.statusCode}');
        developer.log('Cuerpo de la respuesta: ${response.body}');
        return result;
      }
    } catch (e) {
      developer.log('Error de conexión: $e');
      return null;
    }

    return result;
  }

  Future<int?> sendScheduleToApi(Schedule schedule) async {
    try {
      final response = await api.POST(_endPoint, schedule.toJson());
      developer.log('schedule');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        return responseData['id'];
      } else {
        developer.log('Error al enviar usuario: ${response.statusCode}');
        developer.log('Error al enviar usuario: ${response.body}');
      }
    } catch (e) {
      developer.log('Error de conexión: $e');
    }
  }
}

import 'dart:convert';
import 'package:proyecto_moviles/utils/api.dart';
import 'package:proyecto_moviles/models/Booking.dart';
import 'dart:developer' as developer;

class BookingService {
  BookingService();

  final ApiConsumer api = ApiConsumer();
  final _endPoint = 'bookings';

  Future<Booking?> getBooking(String? id) async {
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
            var booking = Booking.fromJson(responseBody);
            return booking;
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

  Future<List<Booking>?> getBookings() async {
    List<Booking> result = [];
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
              var booking = Booking.fromJson(item);
              result.add(booking);
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

  Future<List<Booking>?> getBookingsByLab(String id) async {
    List<Booking> result = [];
    try {
      final endPoint = '$_endPoint/by_lab/$id';
      var response = await api.GET(endPoint);

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          developer.log('El cuerpo de la respuesta está vacío.');
          return result;
        } else {
          try {
            List<dynamic> listBody = jsonDecode(response.body);
            for (var item in listBody) {
              var booking = Booking.fromJson(item);
              result.add(booking);
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

  Future<Booking?> sendBookingToApi(Booking user) async {
    try {
      final response = await api.POST(_endPoint, user.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        developer.log('Usuario enviado exitosamente');
        final responseData = jsonDecode(response.body);
        return Booking.fromJson(responseData);
      } else {
        developer.log('Error al enviar usuario: ${response.statusCode}');
        developer.log('Error al enviar usuario: ${response.body}');
      }
    } catch (e) {
      developer.log('Error de conexión: $e');
    }
  }
}

import 'dart:convert';
import 'package:proyecto_moviles/utils/api.dart';
import 'package:proyecto_moviles/models/Laboratory.dart';
import 'dart:developer' as developer;

class LaboratoryService {
  LaboratoryService();

  final ApiConsumer api = ApiConsumer();
  final _endPoint = 'laboratories';

  Future<Laboratory?> getLaboratory(String? id) async {
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
            var laboratory = Laboratory.fromJson(responseBody);
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



  Future<List<Laboratory>?> getLaboratories() async {
    List<Laboratory> result = [];
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
              var laboratory = Laboratory.fromJson(item);
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

  Future<void> sendLaboratoryToApi(Laboratory user) async {
    try {
      final response = await api.POST(_endPoint, user.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        developer.log('Usuario enviado exitosamente');
      } else {
        developer.log('Error al enviar usuario: ${response.statusCode}');
        developer.log('Error al enviar usuario: ${response.body}');
      }
    } catch (e) {
      developer.log('Error de conexión: $e');
    }
  }
}

import 'dart:convert';
import 'package:proyecto_moviles/utils/api.dart';
import 'package:proyecto_moviles/models/Course.dart';
import 'dart:developer' as developer;

class CourseService {
  CourseService();

  final ApiConsumer api = ApiConsumer();
  final _endPoint = 'courses';

  Future<Course?> getCourse(String? id) async {
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
            var course = Course.fromJson(responseBody);
            return course;
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

  Future<List<Course>?> getUserCourses(String id) async {
    List<Course> result = [];
    try {
      final endPoint = '$_endPoint/by_user/$id';
      var response = await api.GET(endPoint);

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          developer.log('El cuerpo de la respuesta está vacío.');
          return result;
        } else {
          try {
            List<dynamic> listBody = jsonDecode(response.body);
            for (var item in listBody) {
              var course = Course.fromJson(item);
              result.add(course);
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

  Future<List<Course>?> getCourses() async {
    List<Course> result = [];
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
              var course = Course.fromJson(item);
              result.add(course);
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

  Future<void> sendCourseToApi(Course course) async {
    try {
      final response = await api.POST(_endPoint, course.toJson());

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

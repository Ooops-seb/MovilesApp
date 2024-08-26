import 'dart:convert';
import 'package:proyecto_moviles/utils/api.dart';
import 'package:proyecto_moviles/models/User.dart';
import 'dart:developer' as developer;

class UserService {
  UserService();

  final ApiConsumer api = ApiConsumer();
  final _endPoint = 'auth/users';

  Future<List<User>?> getUser(String? id) async {
    List<User> result = [];
    try {
      final endPoint = '$_endPoint/${id}';
      var response = await api.GET(endPoint);

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          return result;
        } else {
          try {
            Map<String, dynamic> ListBody = jsonDecode(response.body);
            var user = User.fromJson(ListBody);
            result.add(user);
          } catch (e) {
            return result;
          }
        }
      } else {
        developer.log('Error al enviar usuario: ${response.statusCode}');
        return result;
      }
    } catch (e) {
      developer.log('Error de conexión: $e');
      return null;
    }
  }

  Future<User?> getUserById(String? id) async {
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
            var user = User.fromJson(responseBody);
            return user;
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

  Future<List<User>?> getUsers() async {
    List<User> result = [];
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
              var user = User.fromJson(item);
              result.add(user);
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

  Future<void> sendUserToApi(User user) async {
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

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
      developer.log(endPoint);
      var response = await api.GET(endPoint);
      developer.log(response.body.toString());

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
        developer.log('Respuesta del servidor: ${response.body}');
        return result;
      }
    } catch (e) {
      developer.log('Error de conexión: $e');
      return null;
    }
  }

  Future<void> sendUserToApi(User user) async {
    try {
      final response = await api.POST(_endPoint, user.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        developer.log('Usuario enviado exitosamente: ${response.body}');
      } else {
        developer.log('ERROR SEND USER ${user.toJson()}');
        developer.log('Endopoint ${_endPoint}');
        developer.log('Error al enviar usuario: ${response.statusCode}');
        developer.log('Respuesta del servidor: ${response.body}');
      }
    } catch (e) {
      developer.log('Error de conexión: $e');
    }
  }
}

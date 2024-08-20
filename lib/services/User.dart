import 'dart:convert';
import 'package:proyecto_moviles/utils/api.dart';
import 'package:proyecto_moviles/models/User.dart';
import 'dart:developer' as developer;

class UserService {
  UserService();

  final ApiConsumer api = ApiConsumer();
  final _endPoint = 'auth/users';

  Future<List<User>?> getUser(String id) async {
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
        developer.log('api ' + response.statusCode.toString());
        return result;
      }
    } catch (e) {
      developer.log(e.toString());
      return null;
    }
  }
}

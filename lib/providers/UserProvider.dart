import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:proyecto_moviles/enums/role.dart';
import 'package:proyecto_moviles/models/User.dart';
import 'package:proyecto_moviles/providers/AuthProvider.dart';
import 'package:proyecto_moviles/services/User.dart';

class UserProvider extends ChangeNotifier {
  final AuthProvider _authProvider;
  bool _isUserBeingLoaded = false;

  UserProvider(this._authProvider) {
    _authProvider.addListener(_updateUser);
    _updateUser();
  }

  String? _id;
  String? get id => _id;

  String? _fullName;
  String? get fullName => _fullName;

  String? _email;
  String? get email => _email;

  String? _imageUrl;
  String? get imageUrl => _imageUrl;

  String? _role;
  String? get role => _role;

  bool? _isActive;
  bool? get isActive => _isActive;

  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;

  DateTime? _lastSignIn;
  DateTime? get lastSignIn => _lastSignIn;

  void _updateUser() async {
    if (_isUserBeingLoaded) return;

    _isUserBeingLoaded = true;

    try {
      final currentUser = auth.FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        await _loadOrRegisterUser(currentUser);
      } else {
        _resetUserData();
      }
    } finally {
      _isUserBeingLoaded = false;
    }
  }

  Future<void> _loadOrRegisterUser(auth.User currentUser) async {
    UserService service = UserService();

    List<User>? _userList = await service.getUser(currentUser.uid);

    if (_userList != null && _userList.isNotEmpty) {
      _setUserData(_userList.first);
    } else {
      User user = User(
        id: currentUser.uid,
        fullName: currentUser.displayName ?? '',
        imageUrl: currentUser.photoURL ?? '',
        email: currentUser.email ?? '',
        role: RoleEnum.profesor,
        isActive: true,
        createdAt: currentUser.metadata.creationTime ?? DateTime.now(),
        updatedAt: currentUser.metadata.lastSignInTime ?? DateTime.now(),
        lastSignIn: currentUser.metadata.lastSignInTime ?? DateTime.now(),
      );
      await service.sendUserToApi(user);
      _setUserData(user);
    }
  }

  void _setUserData(User user) {
    _id = user.id;
    _fullName = user.fullName;
    _email = user.email;
    _imageUrl = user.imageUrl;
    _role = user.role.toString();
    _isActive = user.isActive;
    _createdAt = user.createdAt;
    _updatedAt = user.updatedAt;
    _lastSignIn = user.lastSignIn;
    notifyListeners();
  }

  void _resetUserData() {
    _id = null;
    _fullName = null;
    _email = null;
    _imageUrl = null;
    _role = null;
    _isActive = null;
    _createdAt = null;
    _updatedAt = null;
    _lastSignIn = null;
  }
}
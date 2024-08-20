// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:proyecto_moviles/models/User.dart';
import 'package:proyecto_moviles/providers/AuthProvider.dart';
import 'package:proyecto_moviles/services/User.dart';

class UserProvider extends ChangeNotifier {
  final AuthProvider _authProvider;

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

  DateTime? _createAt;
  DateTime? get createAt => _createAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _updatedAt;

  DateTime? _lastLoginAt;
  DateTime? get lastLoginAt => _lastLoginAt;

  void _updateUser() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = auth.FirebaseAuth.instance.currentUser;
      if (user != null) {
        _id = user.uid;
        _fullName = user.displayName;
        _email = user.email;
        _imageUrl = user.photoURL;
        _role = null; 
        _isActive = true;
        _createAt = user.metadata.creationTime;
        _updatedAt = null;
        _lastLoginAt = user.metadata.lastSignInTime;
      } else {
        _resetUserData();
      }
      notifyListeners();
    });
  }

  Future<void> loadUserData() async {
    final user = auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      _initApiData();
      _imageUrl = user.photoURL;
      _fullName = user.displayName;
      notifyListeners();
    }
  }

  void _resetUserData() {
    _id = null;
    _fullName = null;
    _email = null;
    _imageUrl = null;
    _role = null;
    _isActive = null;
    _createAt = null;
    _updatedAt = null;
    _lastLoginAt = null;
  }

  void _initApiData() async {
    final user = auth.FirebaseAuth.instance.currentUser;
    UserService service = UserService();
    var _user = await service.getUser('asfsaf252asdxczFDSFD');
    print('USUARIOS: $_user');
  }

  @override
  void dispose() {
    _authProvider.removeListener(_updateUser);
    super.dispose();
  }
}
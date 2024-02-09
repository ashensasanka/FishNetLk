import 'package:fishnetlk/features/auth/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Get the authorization
final authProvider = Provider((ref) {
  return AuthRepository();
});

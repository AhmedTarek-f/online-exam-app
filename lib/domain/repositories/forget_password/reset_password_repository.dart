abstract class ResetPasswordRepository {
  Future<String?> resetPassword({
    required String email,
    required String newPassword,
  });
}

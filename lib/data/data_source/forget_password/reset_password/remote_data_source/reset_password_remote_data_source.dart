abstract class ResetPasswordRemoteDataSource {
  Future<String?> resetPassword({
    required String email,
    required String newPassword,
  });
}

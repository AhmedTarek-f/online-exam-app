abstract class EmailVerificationRepository {
  Future<String?> verifyEmail({required String code});
}

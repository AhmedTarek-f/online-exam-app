abstract class ForgetPasswordEmailRepository {
  Future<String?> sendEmailVerification({required String email});
}

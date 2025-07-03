abstract class ForgetPasswordEmailRemoteDataSource {
  Future<String?> sendEmailVerification({required String email});
}

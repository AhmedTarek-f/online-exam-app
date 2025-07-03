abstract class EmailVerificationRemoteDataSource {
  Future<String?> verifyEmailCode({required String code});
}

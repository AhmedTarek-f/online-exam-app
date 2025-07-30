import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/api/data_source/edit_profile/remote_data_source/edit_profile_remote_data_source_impl.dart';
import 'package:online_exam_app/api/requests/edit_profile_request/edit_profile_request.dart';
import 'package:online_exam_app/data/repositories/edit_profile/edit_profile_repository_impl.dart';

import 'edit_profile_repository_impl_test.mocks.dart';

@GenerateMocks([EditProfileRemoteDataSourceImpl])
void main() {
  group('test edit profile method at repo impl', () {
    test(
      "when call editProfile it should be called successfully from editProfileRemoteDataSource",
      () async {
        // Arrange
        MockEditProfileRemoteDataSourceImpl mockedEditProfileRemoteDataSource =
            MockEditProfileRemoteDataSourceImpl();
        final EditProfileRepositoryImpl editProfileRepositoryImpl =
            EditProfileRepositoryImpl(
              editProfileRemoteDataSource: mockedEditProfileRemoteDataSource,
            );
        EditProfileRequest request = EditProfileRequest(
          username: "ahmed tarek",
          firstName: "ahmed",
          lastName: "tarek",
          phone: "011145",
          email: "ahmed@gmail.com",
        );
        when(
          mockedEditProfileRemoteDataSource.editProfile(request: request),
        ).thenAnswer((_) async {});

        // Act
        await editProfileRepositoryImpl.editProfile(request: request);

        // Assert
        verify(
          mockedEditProfileRemoteDataSource.editProfile(request: request),
        ).called(1);
      },
    );
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/api/requests/edit_profile_request/edit_profile_request.dart';
import 'package:online_exam_app/domain/repositories/edit_profile/edit_profile_repository.dart';
import 'package:online_exam_app/domain/use_cases/edit_profile/edit_profile_use_case.dart';

import 'edit_profile_use_case_test.mocks.dart';

@GenerateMocks([EditProfileRepository])
void main() {
  test(
    'when call invoke it should use editProfileRepository to call editProfile',
    () async {
      // Arrange
      MockEditProfileRepository mockEditProfileRepository =
          MockEditProfileRepository();
      EditProfileUseCase useCase = EditProfileUseCase(
        mockEditProfileRepository,
      );
      EditProfileRequest request = EditProfileRequest(
        username: "ahmed tarek",
        firstName: "ahmed",
        lastName: "tarek",
        phone: "011145",
        email: "ahmed@gmail.com",
      );
      when(
        mockEditProfileRepository.editProfile(request: request),
      ).thenAnswer((_) async {});

      // Act
      await useCase.invoke(request: request);

      // Assert
      verify(mockEditProfileRepository.editProfile(request: request)).called(1);
    },
  );
}

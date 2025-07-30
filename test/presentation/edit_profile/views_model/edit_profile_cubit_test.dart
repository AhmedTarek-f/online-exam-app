import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_exam_app/api/requests/edit_profile_request/edit_profile_request.dart';
import 'package:online_exam_app/domain/use_cases/edit_profile/edit_profile_use_case.dart';
import 'package:online_exam_app/presentation/edit_profile/views_model/edit_profile_cubit.dart';
import 'package:online_exam_app/presentation/edit_profile/views_model/edit_profile_intent.dart';

import 'edit_profile_cubit_test.mocks.dart';

@GenerateMocks([EditProfileUseCase])
void main() {
  group("Edit Profile Cubit Test", () {
    test(
      'Call doIntent with UpdateProfileIntent to check Edit profile Success State',
      () async {
        // Arrange
        MockEditProfileUseCase mockEditProfileUseCase =
            MockEditProfileUseCase();
        EditProfileCubit editProfileCubit = EditProfileCubit(
          editProfileUseCase: mockEditProfileUseCase,
        );

        EditProfileRequest request = EditProfileRequest(
          username: "ahmed tarek",
          firstName: "ahmed",
          lastName: "tarek",
          phone: "011145",
          email: "ahmed@gmail.com",
        );

        var intent = UpdateProfileIntent();

        when(
          mockEditProfileUseCase.invoke(request: request),
        ).thenAnswer((_) async {});

        // Act
        await editProfileCubit.doIntent(intent: intent);

        // Assert

        verify(mockEditProfileUseCase.invoke(request: request)).called(1);
      },
    );
  });
}

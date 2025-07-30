// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:online_exam_app/api/client/api_client.dart';
// import 'package:online_exam_app/api/data_source/edit_profile/remote_data_source/edit_profile_remote_data_source_impl.dart';
// import 'package:online_exam_app/api/models/user_model/user_model.dart';
// import 'package:online_exam_app/api/requests/edit_profile_request/edit_profile_request.dart';
// import 'package:online_exam_app/api/responses/edit_profile_response/edit_profile_response.dart';
// import 'package:online_exam_app/utils/exam_method_helper.dart';
//
// import 'edit_profile_remote_data_source_impl_test.mocks.dart';
//
// @GenerateMocks([ApiClient])
// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   group("test edit profile method ", () {
//     test(
//       'when call editProfile it should edit user profile from Api with correct parameters',
//       () async {
//         //Arrange
//         MockApiClient mockApiClient = MockApiClient();
//         EditProfileRemoteDataSourceImpl remoteDataSource =
//             EditProfileRemoteDataSourceImpl(apiClient: mockApiClient);
//         EditProfileRequest request = EditProfileRequest(
//           username: "ahmed tarek",
//           firstName: "ahmed",
//           lastName: "tarek",
//           phone: "011145",
//           email: "ahmed@gmail.com",
//         );
//         String? token = ExamMethodHelper.currentUserToken ?? "";
//         final bool connection = true;
//         when(
//           mockApiClient.editProfile(request: request, token: token),
//         ).thenAnswer(
//           (_) async => EditProfileResponse(
//             message: "data returned",
//             user: UserModel(
//               email: "ahmed@gmail.com",
//               phone: "01116811741",
//               lastName: "ahmed",
//               firstName: "tarek",
//               username: "ahmed tarek",
//               password: "ahmed123",
//               createdAt: "2015",
//               Id: "20200023",
//               isVerified: true,
//               passwordChangedAt: "2012",
//               role: "developer",
//             ),
//           ),
//         );
//         //Act
//         if (connection) {
//           await remoteDataSource.editProfile(request: request);
//         }
//         //Assert
//         // expect(actualResult., matcher)
//       },
//     );
//   });
// }

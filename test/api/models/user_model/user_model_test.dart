import 'package:flutter_test/flutter_test.dart';
import 'package:online_exam_app/api/models/user_model/user_model.dart';
import 'package:online_exam_app/domain/entities/login/user_login_entity.dart';

void main() {
  group("test toUserLoginEntity", () {
    test(
      "when call toUserLoginEntity with null values it should return UserLoginEntity with null values",
      () {
        //Arrange
        UserModel userData = UserModel(
          email: null,
          phone: null,
          lastName: null,
          firstName: null,
          username: null,
          password: null,
          createdAt: null,
          Id: null,
          isVerified: null,
          passwordChangedAt: null,
          role: null,
        );

        //Act
        UserLoginEntity actualResult = userData.toUserLoginEntity();

        //Assert
        expect(actualResult.username, isNull);
        expect(actualResult.firstName, isNull);
        expect(actualResult.lastName, isNull);
        expect(actualResult.phone, isNull);
        expect(actualResult.email, isNull);
      },
    );
    test(
      "when call toUserLoginEntity with non-nullable values it should return UserLoginEntity with correct values",
      () {
        //Arrange
        UserModel userData = UserModel(
          email: "ahmed@gmail.com",
          phone: "01116811741",
          lastName: "ahmed",
          firstName: "tarek",
          username: "ahmed tarek",
          password: "ahmed123",
          createdAt: "2015",
          Id: "20200023",
          isVerified: true,
          passwordChangedAt: "2012",
          role: "developer",
        );

        //Act
        UserLoginEntity actualResult = userData.toUserLoginEntity();

        //Assert
        expect(actualResult.username, equals(userData.username));
        expect(actualResult.firstName, equals(userData.firstName));
        expect(actualResult.lastName, equals(userData.lastName));
        expect(actualResult.phone, userData.phone);
        expect(actualResult.email, userData.email);
      },
    );
  });
}

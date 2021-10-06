// import 'package:flutter_test/flutter_test.dart';
// import 'package:frontend/DataProvider/Auth/Auth.dart';
// import 'package:frontend/Models/models.dart';
// import 'package:frontend/Utilities/Constants.dart';
// import 'package:mockito/mockito.dart';

// import 'package:http/http.dart' as http;

// class MockHttpUser extends Mock implements http.Client {}

// void main() {
//   group(
//     "AuthDataProviderTest",
//     () {
//       test(
//         "Register a user",
//         () async {
//           final _baseUrl = Uri.parse('$API_URL/RegisterUser');

//           when(
//             http.post(
//               _baseUrl,
//               headers: anyNamed('headers'),
//               body: anyNamed('body'),
//             ),
//           ).thenAnswer(
//             (_) async => http.Response(
//                 '{ "fullName": "somefullname", "userName": "someusername","emailAdress": "someemailaddress", "password":"somepassword", "confirmPassword": "somepassword", "userRole": "someUserRole", "id": "SomeId"}',
//                 200),
//           );

//           expect(
//               await ClientAuthDataProvider.register(User(
//                 "se.mekuanint@gmail.com",
//                 "password",
//                 fullName: "fullname",
//                 userName: "username",
//                 confirmPassword: "password",
//                 userRole: "role",
//                 id: "id",
//               )),
//               isA<User>());
//         },
//       );
//     },
//   );
// }

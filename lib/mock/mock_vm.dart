// import 'dart:convert';

// import 'package:ecom/Model/user.dart';
// import '../viewmodel.dart';

// import 'package:http/http.dart' as http;

// class MockVM implements ViewModel {

//   @override
//   Future<List<User>> fetchUsers() async {
//     final response = await http.get(Uri.parse(
//         'https://run.mocky.io/v3/33c63232-c381-4dc6-b84c-47c36ce188c5'));

//     if (response.statusCode == 200) {
//       // If the server did return a 200 OK response,
//       // then parse the JSON.
//       var list = jsonDecode(response.body)['users'];
//       List<User> users = List.empty(growable: true);
//       for (var user in list) {
//         users.add(User.fromJson(user));
//       }
//       return users;

//     } else {
//       // If the server did not return a 200 OK response,
//       // then throw an exception.
//       throw Exception('Failed to load');
//     }
//   }
  
//   @override
//   bool registerUser(User user) {
//   //   final response = await http.post(
//   //   Uri.parse('https://run.mocky.io/v3/aec14f3e-698b-4dca-9fb7-1b0f59af7721'),
//   //   headers: <String, String>{
//   //     'Content-Type': 'application/json; charset=UTF-8',
//   //   },
//   //   body: jsonEncode(user),
//   // );

//   //   return response.statusCode == 201;
//     return true;
//   }
// }

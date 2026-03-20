
import 'package:fronend_flutter/API/linkAPI.dart';
import 'package:fronend_flutter/screen_crud/model/users.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String linkAPI_getall = fullLinkApi.linkAPI_getAll;



//add user 
// Future<void> AddUser(Users user) async{
//   final response = await http.post(
//     Uri.parse(linkAPI_getall),
//     headers: {
//       'Content-Type': 'application/json'
//     },
//     body: jsonEncode(user.toJson())
//   );

//   (response.statusCode==201)?print("add succes"):print("add fail: ${response.body}");

  
// }
// //load ds user
// Future<List<Users>> fetchUsers() async{
//   print("lnk: $linkAPI_getall");
//   final response = await http.get(
//     Uri.parse("$linkAPI_getall")
//   );

//   print("res: ${response.body}");

//   if(response.statusCode==200){
//     print("jogin model");
//   List data = jsonDecode(response.body);
//   return data.map((e) => Users.fromJson(e)).toList(); 

//   }
//   else{
//     throw Exception("Failed to load users");
//   }
// }


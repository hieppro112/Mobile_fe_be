import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:fronend_flutter/API/Api_handel.dart';
import 'package:fronend_flutter/screen_crud/model/users.dart';
import 'package:http/http.dart' as http;

class data_provider extends ChangeNotifier {
  Users? _user;
  int _id = 0;
  int get id => _id;
  String _username = "";
  String _address = "";
  List<Users> _listUs = [];


  //check
  String _message="";
  bool _success=false;
  int _selectedUserId = 0; // thêm selected user id
  String get message => _message;
  bool get success => _success;
  int get selectedUserId => _selectedUserId;


  //loading danh sach
  bool isLoading = false;
  //loi cua danh sach
  String err = "";

  String get username => _username;
  String get address => _address;
  List<Users> get listUs => _listUs;
  Users? get user => _user;

  //controller
  TextEditingController txt_name = TextEditingController();
  TextEditingController txt_address = TextEditingController();


  //chang data controller
  void changData_controller(int? id,String name, String address){
    txt_name.text = name;
    txt_address.text = address;
  }

  void changData_user(Users us){
    _id = us.userId??0;
     txt_address.text = us.address;
     txt_name.text = us.name;
    notifyListeners();
  }

  void changeData_user(String s) {
    // _username = s;
    txt_name.text = s;
    notifyListeners();
  }

  void changeData_address(String s) {
    // _address = s;
    txt_address.text = s;
    notifyListeners();
  }

  void setSelectedUserId(int id) {
    _selectedUserId = id;
    notifyListeners();
  }

  //check data
  Future<void> checkData()async{
    try{
       final response = await http.get(Uri.parse("$linkAPI_getall"));
       if(response.statusCode==200){
        Map<String,dynamic> responseData = jsonDecode(response.body);
        if(responseData["success"]==true){
          _message = responseData["message"];
        }else{
          _message = responseData["message"];
        }
       }
       notifyListeners();
    }
    catch(e){
      _message = e.toString();
    }
  }

  //add user
  Future<void> AddUser(Users user) async {
    final response = await http.post(
      Uri.parse(linkAPI_getall),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      fetchUsers();
      _success = true;
      _message = "Thêm dữ liệu thành công";
      print("add data succes");
    } else {
      _success = false;
      _message = "Thêm dữ liệu thất bại: ${response.body}";
      print("add fail: ${response.body}");
    }
    notifyListeners();
  }

  //delete user
  Future<void> DeleteUser(int id) async {
    final response = await http.delete(
      Uri.parse("$linkAPI_getall/$id"),
    );
    Map<String,dynamic> responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      fetchUsers();
        _message = responseData["message"];
      _success = true;
      print("delete data success");
    } else {
      _success = false;
      _message =responseData["message"];
      print("delete fail: ${response.body}");
    }
    notifyListeners();
  }


//update user
Future<void> updateUser(int id) async {
  Users us = Users(userId: id, name: txt_name.text, address: txt_address.text);
    final response = await http.put(
      Uri.parse("$linkAPI_getall/$id"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(us.toJson()),
    );

    if (response.statusCode == 204) {
      fetchUsers();
      _success = true;
      _message = "Cập nhật dữ liệu thành công";
      print("update data success");
    } else {
      _success = false;
      _message = "Cập nhật dữ liệu thất bại: ${response.body}";
      print("update fail: ${response.body}");
    }
    notifyListeners();
  }



  Future<void> fetchUsers()async {
    notifyListeners();
    try {
      notifyListeners();
      isLoading = true;
      final response = await http.get(Uri.parse("$linkAPI_getall"));
      if (response.statusCode == 200) {

        print("get data start");
        print("res: ${response.body}");
        Map<String,dynamic> responseData = jsonDecode(response.body);
        if(responseData["success"]==true){

        List data = responseData["data"];

        _listUs = data.map((e) => Users.fromJson(e)).toList();
        isLoading =false;
        }
        else{
          
        }
        print("get data success");
      } else {
      err = "lỗi: ket noi";

        throw Exception("Failed to load users");
      }
    } catch (e) {
      err = "lỗi: $e";
    }

    notifyListeners();

  }
}

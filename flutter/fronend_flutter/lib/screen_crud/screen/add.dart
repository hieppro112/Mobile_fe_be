import 'package:flutter/material.dart';
import 'package:fronend_flutter/API/Api_handel.dart';
import 'package:fronend_flutter/provider/provider_couter.dart';
import 'package:fronend_flutter/screen_crud/model/users.dart';
import 'package:fronend_flutter/screen_crud/screen/dialog_show.dart';
import 'package:provider/provider.dart';

class add_Data_button extends StatelessWidget {
  const add_Data_button({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.blue
      ),
      child:InkWell(

        onTap: () async {
          print("add data");
          String valueUser = context.read<data_provider>().txt_name.text;
          String valueAddress = context.read<data_provider>().txt_address.text;
          Users us = Users(userId: 0, name: valueUser, address: valueAddress);
          await context.read<data_provider>().AddUser(us);
          _showResultDialog(context);
        },
        child: Text("Add data", style: TextStyle(
        fontSize: 12,
        color: Colors.black
      ),),
      )
      
    );
  }

  void _showResultDialog(BuildContext context) {
    bool check = context.read<data_provider>().success;
    String message = context.read<data_provider>().message;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(check ? 'Thành công' : 'Thất bại'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
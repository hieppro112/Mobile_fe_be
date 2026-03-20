import 'package:flutter/material.dart';
import 'package:fronend_flutter/provider/provider_couter.dart';
import 'package:fronend_flutter/screen_crud/screen/add.dart';
import 'package:fronend_flutter/screen_crud/screen/delete.dart';
import 'package:fronend_flutter/screen_crud/screen/dialog_show.dart';
import 'package:fronend_flutter/screen_crud/screen/listData.dart';
import 'package:fronend_flutter/screen_crud/screen/txt_info.dart';
import 'package:fronend_flutter/screen_crud/screen/update.dart';
import 'package:provider/provider.dart';

class crud_data extends StatefulWidget {
  const crud_data({super.key});

  @override
  State<crud_data> createState() => _crud_dataState();
}

class _crud_dataState extends State<crud_data> {

  @override void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      context.read<data_provider>().fetchUsers();
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //title
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Danh sach thanh vien", 
        style: TextStyle(
          color: Colors.black,
          fontSize: 14
        ),),
        centerTitle: true,
      ),
    body: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            add_Data_button(),
            Delete_Data_button(),
            update_Data_button(),
          ],
          
        ),

        txt_info(),
        Expanded(child: List_data()),
      ],
    )
    );
  }
}
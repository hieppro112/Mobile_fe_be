import 'package:flutter/material.dart';
import 'package:fronend_flutter/provider/provider_couter.dart';
import 'package:provider/provider.dart';

class txt_info extends StatelessWidget {
  const txt_info({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController txt_name = context.read<data_provider>().txt_name;
    TextEditingController txt_address = context.read<data_provider>().txt_address;
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        children: [
          TextField(
            
            controller: txt_name,
          decoration: InputDecoration(
            hintText: "Name user",
            // border: 
          ),
          onChanged:(value) =>  context.read<data_provider>().changeData_user(value),),
          TextField(controller: txt_address,
          decoration: InputDecoration(
            hintText: "Address user"
          ),
          onChanged: (value) => context.read<data_provider>().changeData_address(value),),
        ],
      ),
    );
  }
}

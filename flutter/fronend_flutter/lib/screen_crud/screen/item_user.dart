import 'package:flutter/material.dart';
import 'package:fronend_flutter/provider/provider_couter.dart';
import 'package:provider/provider.dart';

class Item_user extends StatefulWidget {
  const Item_user({super.key});

  @override
  State<Item_user> createState() => Item_userState();
}

class Item_userState extends State<Item_user> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          Text(context.watch<data_provider>().username.toString()),
          Text(context.watch<data_provider>().address.toString()),
        ],
      ),
      onTap: () {
        
      },
    );
  }
}
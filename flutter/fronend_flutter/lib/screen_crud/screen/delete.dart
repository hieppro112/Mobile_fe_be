import 'package:flutter/material.dart';
import 'package:fronend_flutter/provider/provider_couter.dart';
import 'package:provider/Provider.dart';

class Delete_Data_button extends StatelessWidget {
  const Delete_Data_button({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromARGB(255, 236, 14, 14)
      ),
      child:InkWell(

        onTap: () async {
          int id = context.read<data_provider>().id;
          if (id != 0) {
            await context.read<data_provider>().DeleteUser(id);
            _showResultDialog(context);
          } else {
            // Có thể show dialog chọn user
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Chọn user để xóa")));
          }
        },
        child: Text("Detele data", style: TextStyle(
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
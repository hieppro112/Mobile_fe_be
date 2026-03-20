import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fronend_flutter/provider/provider_couter.dart';
import 'package:provider/provider.dart';

class DialogShow extends StatefulWidget {
  const DialogShow({super.key});


  @override
  State<DialogShow> createState() => _DialogShowState();
}

class _DialogShowState extends State<DialogShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dialog Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showResultDialog(context);
          },
          child: Text('Show Result'),
        ),
      ),
    );
  }

  void _showResultDialog(BuildContext context) {
    bool check = context.read<data_provider>().success;
    String mess = context.read<data_provider>().message;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(check ? 'Thành công' : 'Thất bại'),
        content: Text(mess),
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
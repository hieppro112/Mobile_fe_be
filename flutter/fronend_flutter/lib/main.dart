import 'package:flutter/material.dart';
import 'package:fronend_flutter/provider/provider_couter.dart';
import 'package:fronend_flutter/screen_crud/layout_crud.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) =>data_provider() ,
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
      ),
       home: const crud_data(),
    ),);
  }
}

import 'package:flutter/material.dart';
import 'list_catatan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buku Catatan',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ListCatatan(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:resizablebox/resizable_group_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resizable Boxes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResizableGroupWidget(),
    );
  }
}

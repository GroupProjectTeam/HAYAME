import 'package:flutter/material.dart';
import 'package:hayame/database.dart' as db;
import 'package:hayame/interface/home_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'demo',
    home: home_page(),
    //home: TestPage(),
  ));
}

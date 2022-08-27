import 'package:flutter/material.dart';
import 'package:sqlite/add_employee_screen.dart';
import 'package:sqlite/myHomePage.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings){
    switch (settings.name) {
      case '/':
      return MaterialPageRoute(builder: (_)=>MyHomePage());
      case '/add_employee':  
       return MaterialPageRoute(builder: (_)=>AddEmployeeScreen());
      default:
       return MaterialPageRoute(builder: (_)=>MyHomePage()); 
      
    }
  }
}
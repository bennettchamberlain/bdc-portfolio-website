import 'package:flutter/material.dart';

abstract class UIComponent  {
  final int priority;
  final String type;
  

  const UIComponent({required this.priority, required this.type});


  int getPriority(){
    return priority;
  }
  String getType(){
    return type;
  }

  Widget getWidget(){
    throw Exception();
  }
  toJson(){
    throw Exception();
  }
}
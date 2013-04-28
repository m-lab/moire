library view;
import 'package:web_ui/observe.dart';
import 'package:web_ui/observe/html.dart';
import 'dart:json';
import 'dart:html';

class View{
  //TODO: implement view model
 
}

class Chart extends View{
  //TODO: implement graphs
  
  void drawLineChart(){
    //TODO implement drawing a line chart using charts api
  }
  
  void drawBarChart(){
    //TODO implement drawing a bar chart using charts api
  }
  
  void drawPieChart(){
    //TODO implement drawing a line chart using charts api
  }
}

class Maps extends View{
  num lat;
  num long;
  
  void drawMap(){
    //Use Dart library to build map
  }
  
}

class Menu extends View{
  //TODO: implement menus
}

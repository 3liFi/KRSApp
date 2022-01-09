import 'package:flutter/material.dart';
import 'package:krs_app/screens/edit_classes.dart';
import 'package:krs_app/screens/sub_list.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
  
    //switch to find the route by name
    switch (settings.name) {
      //home page (contains list of substitutions)
      case '/':
        return MaterialPageRoute(builder: (BuildContext context) => SubList());
      //page to select the saved classes
      case '/editClasses':
        return MaterialPageRoute(builder: (BuildContext context) =>  EditClasses());

        //if the specified route could not be found either an error page needs to be returnded or an Exception needs to be thrown
      default: throw const FormatException('route not found');
    }
  }
}
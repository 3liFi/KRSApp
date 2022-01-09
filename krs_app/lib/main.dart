import 'package:flutter/material.dart';

///import 'package:krs_app/dsb_manager.dart';
import 'package:krs_app/route_generator.dart';
import 'package:provider/provider.dart';
import 'package:krs_app/providers/saved_classes_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SavedClasses(),
        ),
      ],
      child: const MyApp(),
    ),
  );
  //DSBManager dsb = DSBManager();
  //dsb.getData();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //Route that displays all the Substitutions
      initialRoute: '/',
      //dynamic route generation, allows for data to be passed on to pages
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

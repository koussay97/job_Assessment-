import 'package:flutter/material.dart';
import 'package:mint_it_asses/core/utils/routing_configuration/route_generator.dart';
import 'package:mint_it_asses/viewModels/formState_view_model.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider<FormStateViewModel>(create: (_) => FormStateViewModel()),
          ],
          child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

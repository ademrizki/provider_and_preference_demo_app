import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_and_preference_demo_app/src/provider/home_provider.dart';
import 'package:provider_and_preference_demo_app/src/view/screen/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(),
        ),
      ],
      builder: (context, _) => MaterialApp(
        title: 'Flutter Provider & Shared Preference Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

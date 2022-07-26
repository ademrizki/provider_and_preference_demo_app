import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_and_preference_demo_app/src/provider/home_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'register_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future checkLogin() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final bool? isLogin = sharedPreferences.getBool('isLogin');

    if (isLogin == null) {
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        ),
      );
    }

    context.read<HomeProvider>().fetchNameAndEmail();
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Name Text
            Consumer<HomeProvider>(
              builder: (context, provider, _) {
                return Text(
                  'Hello, ${provider.name ?? 'Name'}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),

            /// Email Text
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Consumer<HomeProvider>(
                builder: (context, provider, _) {
                  return Text(
                    provider.email ?? 'name@mail.com',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
            ),

            /// Logout Button
            ElevatedButton(
              onPressed: () async {
                final SharedPreferences preference =
                    await SharedPreferences.getInstance();

                await preference.clear();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(),
                  ),
                );
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}

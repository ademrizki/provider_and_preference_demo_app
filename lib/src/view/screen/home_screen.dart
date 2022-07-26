import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider_and_preference_demo_app/src/bloc/name_bloc/name_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/email_bloc/email_bloc.dart';
import 'register_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NameBloc nameBloc;
  late EmailBloc emailBloc;

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
  }

  @override
  void initState() {
    nameBloc = NameBloc();
    emailBloc = EmailBloc();

    nameBloc.add(GetName());
    emailBloc.add(GetEmail());

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
            BlocBuilder<NameBloc, NameState>(
              bloc: nameBloc,
              builder: (context, state) {
                if (state is Loading) {
                  return const CircularProgressIndicator();
                } else if (state is Success) {
                  return Text(
                    'Hello, ${state.name}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),

            /// Email Text
            BlocBuilder<EmailBloc, EmailState>(
              bloc: emailBloc,
              builder: (context, state) {
                if (state is EmailLoading) {
                  return const CircularProgressIndicator();
                } else if (state is EmailSuccess) {
                  return Text(
                    state.email,
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else {
                  return const SizedBox();
                }
              },
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
                    builder: (context) => const RegisterScreen(),
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

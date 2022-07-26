import 'package:flutter/material.dart';
import 'package:provider_and_preference_demo_app/src/view/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final ValueNotifier<bool> isObscure = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Name Field
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  validator: (String? value) =>
                      value == null || value == '' || value.length < 3
                          ? 'Add Name Properly'
                          : null,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                    filled: true,
                  ),
                ),
              ),

              /// Email Field
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) =>
                      value == null || value == '' || value.length < 3
                          ? 'Add Email Properly'
                          : null,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                    filled: true,
                  ),
                ),
              ),

              /// Phone Number Field
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (String? value) =>
                      value == null || value == '' || value.length < 11
                          ? 'Add Phone number Properly'
                          : null,
                  decoration: const InputDecoration(
                    label: Text('Phone number'),
                    filled: true,
                  ),
                ),
              ),

              /// Password Field
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ValueListenableBuilder<bool>(
                  valueListenable: isObscure,
                  builder: (context, obscure, _) {
                    return TextFormField(
                      controller: passwordController,
                      obscureText: obscure,
                      validator: (String? value) =>
                          value == null || value == '' || value.length < 3
                              ? 'Add Password Properly'
                              : null,
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        filled: true,
                        suffixIcon: IconButton(
                          onPressed: () => isObscure.value = !isObscure.value,
                          icon: Icon(
                            obscure ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// Register Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(
                    double.infinity,
                    42,
                  ),
                ),
                child: const Text('Register'),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    final SharedPreferences preference =
                        await SharedPreferences.getInstance();

                    await preference.setString('name', nameController.text);
                    await preference.setString('email', emailController.text);
                    await preference.setBool('isLogin', true);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

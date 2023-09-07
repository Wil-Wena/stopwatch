import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loggedIn = false;
  String? name;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: loggedIn ? buildSuccess() : buildLoginForm(),
      ),
    );
  }

  Widget buildSuccess() {
    return Column(
      children: [
        const Icon(
          Icons.check,
          color: Colors.deepOrangeAccent,
        ),
        Text("Hello $name"),
      ],
    );
  }

  Widget buildLoginForm() {
    void validate() {
      final form = formKey.currentContext;
      if (form?.validate()) {
        return;
      }
      setState(() {
        loggedIn = true;
        name = nameController.text;
      });
    }

    return Form(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (text) =>
                  text!.isEmpty ? "Enter the runner's name." : null,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (text) {
                if (text!.isEmpty) {
                  return 'Enter the runner\'s email.';
                }
                final regex = RegExp('[^@]+@[^.]+..+');
                if (!regex.hasMatch(text)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: validate, child: Text("Continue"))
          ],
        ),
      ),
    );
  }
}

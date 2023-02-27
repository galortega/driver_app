import 'package:driver_app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController codeController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200.0,
              child: TextField(
                controller: codeController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24.0),
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter 4-digit code',
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text('Log In'),
              onPressed: () async {
                String code = codeController.text;
                if (code.length == 4) {
                  final authService =
                      Provider.of<AuthService>(context, listen: false);

                  final response = await authService.login(code);
                  // If successful, navigate to the orders page
                  if (response == null) {
                    void switchToBrightness() {
                      Navigator.pushReplacementNamed(context, 'orders');
                    }

                    switchToBrightness();
                  } else {
                    // Show an error message
                    void showError() {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: Text(response),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }

                    showError();
                  }
                } else {
                  // Show an error message
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please enter a 4-digit code.'),
                        actions: [
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

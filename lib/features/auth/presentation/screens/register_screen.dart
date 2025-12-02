import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/spacings.dart';

@RoutePage()
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.lg),
          child: Column(
            children: [
              TextField(decoration: InputDecoration(labelText: 'Name')),
              const SizedBox(height: Spacing.md),
              TextField(decoration: InputDecoration(labelText: 'Email')),
              const SizedBox(height: Spacing.md),
              TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: Spacing.lg),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement register logic
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turbovetschat/config/routes/app_router.dart';

import '../../../../core/themes/spacings.dart';
import '../../../../core/utils/asset_names.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetNames.iconMessage,
                width: 120,
                height: 120,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.inverseSurface,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: Spacing.xl),
              Text(
                'Welcome to TurboVets Chat',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Spacing.sm),
              Text(
                'Connect with support agents instantly',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Spacing.xxl),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.router.push(const LoginRoute());
                  },
                  child: const Text('Login'),
                ),
              ),
              const SizedBox(height: Spacing.md),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    context.router.push(const RegisterRoute());
                  },
                  child: const Text('Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

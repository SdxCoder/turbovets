import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turbovetschat/config/injection/injection.dart';
import 'package:turbovetschat/config/routes/app_router.dart';
import 'package:turbovetschat/core/themes/spacings.dart';
import 'package:turbovetschat/core/utils/asset_names.dart';

import '../../../splash/presentation/bloc/splash_cubit.dart';
import '../../../splash/presentation/bloc/splash_state.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SplashCubit>()..checkSession(),
      child: const WelcomeView(),
    );
  }
}

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashAuthenticated) {
          context.router.replace(const HomeRoute());
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}

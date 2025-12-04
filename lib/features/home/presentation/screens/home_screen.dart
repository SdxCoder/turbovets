import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turbovetschat/config/injection/injection.dart';
import 'package:turbovetschat/features/agents/presentation/bloc/agent_cubit.dart';

import '../../../../core/utils/asset_names.dart';
import '../../../chat/presentation/screens/chats_screen.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';
import '../../../profile/presentation/screens/settings_screen.dart';
import '../bloc/tabs_cubit.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TabsCubit()),
        BlocProvider(create: (_) => getIt<AgentCubit>()),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AgentCubit>().initializeAgents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TabsCubit, TabsState>(
        builder: (context, state) {
          return switch (state) {
            TabsState.chats => const ChatsScreen(),
            TabsState.dashboard => const DashboardScreen(),
            TabsState.settings => const SettingsScreen(),
          };
        },
      ),
      bottomNavigationBar: BlocBuilder<TabsCubit, TabsState>(
        builder: (context, state) {
          final selectedTab = state;
          final selectedColor = Theme.of(context).colorScheme.onSurface;
          final unselectedColor = Theme.of(context).colorScheme.secondary;

          return BottomNavigationBar(
            currentIndex: selectedTab.index,
            onTap: (index) {
              context.read<TabsCubit>().selectTab(TabsState.values[index]);
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AssetNames.iconMessage,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    selectedTab == TabsState.chats
                        ? selectedColor
                        : unselectedColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AssetNames.iconSetting,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    selectedTab == TabsState.settings
                        ? selectedColor
                        : unselectedColor,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Settings',
              ),
            ],
          );
        },
      ),
    );
  }
}

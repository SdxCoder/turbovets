import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../settings/presentation/bloc/settings_cubit.dart';
import '../../../settings/presentation/bloc/settings_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  String _getDefaultUrl() {
    // Default URLs based on platform
    return Platform.isAndroid
        ? 'http://10.0.2.2:4200'
        : 'http://localhost:4200';
  }

  String _getServerUrl(String savedUrl) {
    // Use saved URL if available, otherwise use platform default
    if (savedUrl.isNotEmpty) {
      return savedUrl;
    }
    return _getDefaultUrl();
  }

  void _initializeWebView() {
    final settingsState = context.read<SettingsCubit>().state;
    final serverUrl = _getServerUrl(settingsState.dashboardServerUrl);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = true;
                _hasError = false;
              });
            }
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            if (mounted) {
              setState(() {
                _isLoading = false;
                _hasError = true;
                _errorMessage = error.description;
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(serverUrl));
  }

  void _reloadWebView() {
    final settingsState = context.read<SettingsCubit>().state;
    final serverUrl = _getServerUrl(settingsState.dashboardServerUrl);

    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    _controller.loadRequest(Uri.parse(serverUrl));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listenWhen: (previous, current) =>
          previous.dashboardServerUrl != current.dashboardServerUrl,
      listener: (context, state) {
        // Reload WebView when server URL changes
        _reloadWebView();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Internal Tools Dashboard'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _controller.reload();
              },
              tooltip: 'Reload',
            ),
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: _showInfoDialog,
              tooltip: 'Connection Info',
            ),
          ],
        ),
        body: Stack(
          children: [
            // WebView
            if (!_hasError)
              WebViewWidget(controller: _controller)
            else
              _buildErrorWidget(),

            // Loading Indicator
            if (_isLoading)
              Container(
                color: Colors.white,
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    final settingsState = context.watch<SettingsCubit>().state;
    final currentUrl = _getServerUrl(settingsState.dashboardServerUrl);
    final isUsingCustom = settingsState.dashboardServerUrl.isNotEmpty;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 24),
            Text(
              'Failed to Load Dashboard',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              _errorMessage ?? 'Unable to connect to the dashboard server',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current URL:',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 4),
                  SelectableText(
                    currentUrl,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontFamily: 'monospace',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSetupInstructions(isUsingCustom, currentUrl),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _hasError = false;
                  _isLoading = true;
                });
                _controller.reload();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetupInstructions(bool isUsingCustom, String currentUrl) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.errorContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.error.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                size: 20,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(width: 8),
              Text(
                'Setup Required',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (!isUsingCustom) ...[
            if (Platform.isAndroid) ...[
              _buildInstructionItem(
                'For Physical Device',
                'Go to Settings tab and configure server URL with your PC\'s IP address.\n'
                    'Example: http://192.168.1.100:4200',
              ),
              const SizedBox(height: 8),
              _buildInstructionItem(
                'For Emulator',
                'Using default: $currentUrl\n'
                    'Make sure Angular server is running:\n'
                    'cd webpage/internal-tools && npm start',
              ),
            ] else ...[
              _buildInstructionItem(
                'iOS Simulator/Device',
                'Make sure Angular server is running:\n'
                    'cd webpage/internal-tools && npm start\n\n'
                    'For physical device, configure in Settings tab.',
              ),
            ],
          ] else ...[
            _buildInstructionItem(
              'Using Custom Server',
              'URL: $currentUrl\n\n'
                  'Make sure:\n'
                  '1. Angular server is running\n'
                  '2. Device is on same WiFi network\n'
                  '3. Firewall allows port 4200\n\n'
                  'Change in Settings tab if needed.',
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInstructionItem(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontSize: 11, height: 1.4),
        ),
      ],
    );
  }

  void _showInfoDialog() {
    final settingsState = context.read<SettingsCubit>().state;
    final currentUrl = _getServerUrl(settingsState.dashboardServerUrl);
    final isUsingCustom = settingsState.dashboardServerUrl.isNotEmpty;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Connection Info'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInfoRow('Current URL:', currentUrl),
              const SizedBox(height: 12),
              _buildInfoRow('Platform:', Platform.operatingSystem),
              const SizedBox(height: 12),
              _buildInfoRow(
                'Configuration:',
                isUsingCustom ? 'Custom' : 'Default',
              ),
              const SizedBox(height: 12),
              _buildInfoRow('Default URL:', _getDefaultUrl()),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Text(
                'To Change Server:',
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '1. Go to Settings tab\n'
                '2. Tap "Server URL" option\n'
                '3. Enter your server URL\n'
                '4. Tap "Save"\n\n'
                'Dashboard will reload automatically!',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 4),
        SelectableText(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontFamily: value.startsWith('http') ? 'monospace' : null,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

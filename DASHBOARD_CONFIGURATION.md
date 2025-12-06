# Dashboard Server Configuration

## 🎉 No Rebuild Required!

The Flutter app now includes **in-app server configuration** for the Dashboard WebView. Users can change the server URL directly from the app without rebuilding!

---

## ⚙️ How It Works

### User Flow:

```
1. Open App
   ↓
2. Navigate to Settings Tab (⚙️)
   ↓
3. Tap "Server URL" under Dashboard
   ↓
4. Enter Server URL
   ↓
5. Tap "Save"
   ↓
6. Navigate to Dashboard Tab
   ↓
7. Dashboard Loads Automatically!
```

### State Management:

```
SettingsCubit (BLoC)
   ↓
Manages dashboardServerUrl
   ↓
Persists to Hive
   ↓
Dashboard listens via BlocListener
   ↓
Auto-reloads when URL changes
```

---

## 📱 Access Settings

### Location:
- **Tab**: Settings (⚙️ in bottom navigation)
- **Section**: Dashboard
- **Option**: Server URL
- **Alternative**: Dashboard tab → Info button (ℹ️) for current settings

### Settings Dialog Features:

| Feature | Description |
|---------|-------------|
| **URL Input** | Text field to enter custom server address |
| **Default Examples** | Shows platform-specific default URLs |
| **Instructions** | Built-in setup guide for physical devices |
| **Use Default** | Reset button to restore platform default |
| **Save & Reload** | Apply changes immediately |
| **Persistent** | Settings saved using Hive local storage |

---

## 🔧 Configuration Examples

### Android Emulator (Default):
```
http://10.0.2.2:4200
```
- Leave settings empty or tap "Use Default"
- Automatically uses emulator-specific address

### iOS Simulator (Default):
```
http://localhost:4200
```
- Leave settings empty or tap "Use Default"
- Works with Mac's localhost directly

### Physical Device (Custom):
```
http://192.168.1.100:4200
```
1. Find your PC's IP address
2. Enter in settings dialog
3. Save and reload

### Development Server (Custom):
```
http://10.0.0.194:4200
```
- Can use any accessible server URL
- Supports different ports
- Perfect for team development

---

## 💾 Storage Implementation

### Architecture:
- **State Management**: BLoC pattern with SettingsCubit
- **Storage**: Hive local database
- **Layer Separation**: Domain → Data → Hive

### Technology Stack:
- **BLoC**: SettingsCubit manages state
- **Use Cases**: GetDashboardServerUrl, SetDashboardServerUrl
- **Repository**: SettingsRepository interface
- **Implementation**: SettingsRepositoryImpl with HiveService
- **Key**: `dashboard_server_url`
- **Type**: `String` (empty string for default)

### Data Flow:
```
UI (Settings Screen)
   ↓
SettingsCubit.setDashboardServerUrl(url)
   ↓
SetDashboardServerUrl UseCase
   ↓
SettingsRepository.setDashboardServerUrl(url)
   ↓
HiveService.save(key, value)
   ↓
State Updated → BlocListener notifies Dashboard
   ↓
Dashboard reloads with new URL
```

### Behavior:
- **Empty string**: Uses platform default (10.0.2.2 or localhost)
- **Custom value**: Uses saved URL
- **Persists**: Survives app restarts
- **Reactive**: Dashboard auto-reloads on change via BlocListener

### Code Structure:
```dart
// State
class SettingsState {
  final String dashboardServerUrl; // Empty = default
}

// Cubit
class SettingsCubit {
  Future<void> setDashboardServerUrl(String url) async {
    final result = await _setDashboardServerUrl(url);
    emit(state.copyWith(dashboardServerUrl: url));
  }
}

// Dashboard listens
BlocListener<SettingsCubit, SettingsState>(
  listenWhen: (prev, curr) => 
    prev.dashboardServerUrl != curr.dashboardServerUrl,
  listener: (context, state) {
    _reloadWebView(); // Auto-reload!
  },
)
```

---

## 🎨 UI Components

### Dashboard App Bar:

```
┌────────────────────────────────────────┐
│  Internal Tools Dashboard              │
│                         🔄  ℹ️          │
└────────────────────────────────────────┘
                    Refresh  Info
```

### Settings Screen:

```
┌────────────────────────────────────────┐
│  Settings                              │
├────────────────────────────────────────┤
│  User Information                      │
│  📧 Name / Email                       │
│                                        │
│  Appearance                            │
│  🎨 Change Theme                       │
│                                        │
│  Dashboard                             │
│  🔗 Server URL ────────────────────► ✏️│
│     Using platform default             │
│                                        │
│  🚪 Logout                             │
└────────────────────────────────────────┘
```

### Settings Dialog:

```
┌─────────────────────────────────────┐
│  Configure Server URL              X │
├─────────────────────────────────────┤
│                                     │
│  Enter the server address:          │
│                                     │
│  ┌──────────────────────────────┐  │
│  │ 🔗 http://192.168.1.100:4200│  │
│  └──────────────────────────────┘  │
│  Leave empty to use default         │
│                                     │
│  ╔════════════════════════════════╗│
│  ║ ℹ️ Default URLs:               ║│
│  ║ • Android: http://10.0.2.2:... ║│
│  ║ • iOS: http://localhost:4200   ║│
│  ║ • Physical: http://YOUR_IP:... ║│
│  ╚════════════════════════════════╝│
│                                     │
│  For physical devices:              │
│  1. Find your PC's IP               │
│  2. Enter: http://YOUR_IP:4200      │
│  3. Same WiFi network required      │
│                                     │
├─────────────────────────────────────┤
│  Cancel  |  Use Default  |  Save ✓ │
└─────────────────────────────────────┘
```

### Error Screen (when connection fails):

```
┌─────────────────────────────────────┐
│  ⚠️                                  │
│  Failed to Load Dashboard           │
│                                     │
│  net::ERR_CLEARTEXT_NOT_PERMITTED   │
│                                     │
│  Current URL:                       │
│  http://10.0.2.2:4200              │
│                                     │
│  ╔════════════════════════════════╗│
│  ║ ⚡ Setup Required               ║│
│  ║                                ║│
│  ║ For Physical Device:           ║│
│  ║ Tap "Configure Server" and     ║│
│  ║ enter your PC's IP address     ║│
│  ║                                ║│
│  ║ For Emulator:                  ║│
│  ║ Make sure Angular server       ║│
│  ║ is running on port 4200        ║│
│  ╚════════════════════════════════╝│
│                                     │
│   🔧 Configure Server  |  🔄 Retry  │
└─────────────────────────────────────┘
```

---

## ✅ Benefits

### For Users:
- ✅ **No technical knowledge** required
- ✅ **No rebuild** needed to change servers
- ✅ **Works on any device** (emulator, simulator, physical)
- ✅ **Instant feedback** with helpful error messages
- ✅ **Persistent settings** across app restarts
- ✅ **Easy to test** multiple configurations

### For Developers:
- ✅ **Single APK** works everywhere
- ✅ **Easy distribution** without customization
- ✅ **Development flexibility** for team testing
- ✅ **User-friendly** error handling
- ✅ **Clean architecture** with Hive storage
- ✅ **No hardcoded values** in production

### For Testing:
- ✅ **Switch between environments** easily
- ✅ **Test with multiple servers**
- ✅ **No recompilation** overhead
- ✅ **Quick iteration** for debugging
- ✅ **Team collaboration** with shared APK

---

## 🚀 Usage Scenarios

### Scenario 1: Development Team
```
Developer A shares APK with Team
  ↓
Each team member configures their own server
  ↓
Everyone tests with their local Angular instance
  ↓
No conflicts, no rebuilds!
```

### Scenario 2: Physical Device Testing
```
Build APK once
  ↓
Install on multiple physical devices
  ↓
Each device configures PC's IP
  ↓
All devices connect to same server
```

### Scenario 3: Demo/Client Presentation
```
Build production APK
  ↓
Configure for demo server URL
  ↓
Present to client
  ↓
Switch to different server if needed (no rebuild!)
```

---

## 🔒 Security Notes

### Development Mode:
- Current implementation allows **HTTP** (cleartext) traffic
- Network security config includes local IPs (192.168.x.x, 10.0.x.x)
- Perfect for development and testing
- Firewall configuration required

### Production Considerations:
For production apps, consider:
- Use **HTTPS** instead of HTTP
- Remove `usesCleartextTraffic="true"` from AndroidManifest
- Restrict network security config to specific domains
- Implement certificate pinning for enhanced security
- Validate user input for URLs
- Add authentication for server access

---

## 📊 Technical Details

### Dependencies:
- `webview_flutter`: ^4.13.0 (WebView)
- `hive_flutter`: ^1.1.0 (Settings storage)
- No additional packages needed!

### Files Modified:
- `dashboard_screen.dart`: Main implementation
- No other changes required

### Storage:
- Box name: `dashboard_settings`
- Key: `dashboard_server_url`
- Type: String (nullable)
- Persistent: Yes

### Default Behavior:
```dart
Platform.isAndroid ? 'http://10.0.2.2:4200' : 'http://localhost:4200'
```

---

## 🎯 Next Steps

### For End Users:
1. Install the APK
2. Open Dashboard tab
3. Tap settings icon
4. Enter server URL
5. Enjoy!

### For Developers:
1. Build APK once: `fvm flutter build apk --release`
2. Distribute to team/testers
3. Share server setup instructions
4. No per-device customization needed!

---

## 📖 Related Documentation

- **Main README**: [README.md](README.md)
- **Physical Device Setup**: [PHYSICAL_DEVICE_SETUP.md](PHYSICAL_DEVICE_SETUP.md)
- **Assessment Plan**: [ASSESSMENT_PLAN.md](ASSESSMENT_PLAN.md)

---

**This feature makes the app truly flexible and user-friendly! 🎉**


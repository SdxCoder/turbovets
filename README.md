# TurboVets Chat

A Flutter messaging application with intelligent auto-reply agent, real-time chat updates, and image sharing capabilities.

## Project Structure

```
/
├── flutter_app/       # Flutter messaging interface
├── webpage/           # Angular + Tailwind Internal Tools Dashboard
└── README.md          # This file
```

## Getting Started

### Prerequisites
- Flutter SDK 3.10.0 or higher
- Dart SDK 3.10.0 or higher
- iOS Simulator / Android Emulator or physical device

### Setup

1. **Navigate to Flutter app**
   ```bash
   cd flutter_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code** (routing, dependency injection, JSON serialization)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## Features

### 🔐 Authentication
- **Login/Register**: Create account or sign in with email and password 
- **User Profile**: View your name and email in settings

### 💬 Chat
- **Agent Selection**: Browse and select from available agents to start a conversation
- **Real-time Updates**: Chat list and messages update automatically
- **Message Status**: Track sent and read status
- **Unread Count**: See unread message count for each chat

### 📸 Media Sharing
- **Image Attachments**: Pick and send images from gallery
- **Image Display**: View images in chat (local files for your messages, network images for agent replies)

### 🤖 Intelligent Auto-Reply Agent
- **Context-Aware Replies**: Agent analyzes your messages and responds randomly
- **Image Requests**: 
  - Say "image" or "picture" in your text message → Agent sends images (its random)
  - Say "3 pictures" → Agent sends exactly 3 images
  - Otherwise → Agent sends text replies
- **Background Replies**: Receives auto-replies even when not in the message screen

### ⚙️ Settings
- **Theme Toggle**: Switch between light, dark system theme
- **Logout**: Sign out from your account

### 🎨 UI/UX
- **Smooth Animations**: Animated message list with slide-in effects
- **Material Design**: Modern, clean interface
- **Responsive Layout**: Optimized for mobile devices

## How to Explore

1. **Start**: Launch the app → Register/Login with any email and password
2. **Browse Agents**: Tap "Start Chat" → Select an agent from the list
3. **Send Messages**: 
   - Type text messages
   - Tap attachment icon to send images
   - Try: "send me an image" or "3 pictures" to test auto-reply intelligence
4. **View Chats**: Navigate back to see all your conversations sorted by latest message
5. **Settings**: Tap profile icon → Change theme, dashboard IP settings or logout

## Internal Tools Dashboard (WebView)

The app includes an **embedded Angular + Tailwind dashboard** accessible via WebView in the Dashboard tab.

### ⚙️ **Dynamic Server Configuration** (No Rebuild Required!)

The app now includes an **in-app server configuration** feature via the **Settings screen**:
- ✅ **Configure in Settings**: Navigate to Settings tab → Dashboard → Server URL
- ✅ **No rebuild needed**: Change server URL on the fly
- ✅ **BLoC-managed**: Uses SettingsCubit for state management
- ✅ **Persistent**: Settings saved locally using Hive
- ✅ **Smart defaults**: Auto-detects emulator/simulator URLs
- ✅ **Auto-reload**: Dashboard reloads automatically when URL changes
- ✅ **Physical device support**: Enter your PC's IP directly in the app

> **📱 Installing on Physical Device?** Go to Settings tab → Configure Server URL with your PC's IP.  
> **📚 Documentation**: [DASHBOARD_CONFIGURATION.md](DASHBOARD_CONFIGURATION.md) | [PHYSICAL_DEVICE_SETUP.md](PHYSICAL_DEVICE_SETUP.md)

### Dashboard Features:
- **Ticket Viewer**: Browse and filter support tickets
- **Knowledgebase Editor**: Markdown editor with live preview
- **Live Logs Panel**: Real-time system event monitoring

### How to Test:

#### **Option 1: Emulator/Simulator (Development)**

1. **Start the Angular server** (in a separate terminal):
   ```bash
   cd webpage/internal-tools
   npm start
   ```
   Server runs on `http://localhost:4200`

2. **Run the Flutter app**:
   ```bash
   cd flutter_app
   flutter run
   ```

3. **Navigate to Dashboard tab** (third tab in bottom navigation)

4. **The WebView will load automatically**:
   - **Android Emulator**: Uses `http://10.0.2.2:4200`
   - **iOS Simulator**: Uses `http://localhost:4200`

#### **Option 2: Physical Device (APK Installation)**

For **physical phones/tablets**, configure the server URL directly in the app:

```
┌─────────────────┐        WiFi         ┌──────────────────┐
│  Your Computer  │◄──────Network───────►│  Physical Phone  │
│                 │                      │                  │
│  Angular Server │                      │   Flutter App    │
│  Port: 4200     │                      │   (APK)          │
│                 │                      │                  │
│  IP: 192.168... │                      │  Configure in    │
│                 │                      │  Settings Dialog │
└─────────────────┘                      └──────────────────┘
```

**Step 1: Find Your Computer's Local IP**

**Windows:**
```bash
ipconfig
# Look for "IPv4 Address" under your WiFi adapter (e.g., 192.168.1.100)
```

**Mac/Linux:**
```bash
ifconfig | grep "inet "
# Or check System Preferences → Network (e.g., 192.168.1.100)
```

**Step 2: Start Angular Server**

```bash
cd webpage/internal-tools
npm start
```

The server will be accessible on your local network at `http://YOUR_IP:4200`

**Step 3: Install APK**

Transfer the existing `app-release.apk` to your device and install it.
- **No rebuild needed!** Use the APK as-is.

**Step 4: Configure Server in App**

1. **Open the app** and navigate to **Settings tab** (⚙️ in bottom navigation)
2. **Tap "Server URL"** under Dashboard section
3. **Enter your server URL**: `http://192.168.1.100:4200` (use YOUR IP)
4. **Tap "Save"**
5. **Navigate to Dashboard tab** - it will load automatically!

**Step 5: Connect and Test**

1. **Ensure phone and PC are on the same WiFi network**
2. **Check firewall** allows connections on port 4200
3. **Test connection** by opening `http://YOUR_IP:4200` in phone's browser first
4. Dashboard should load in the app!

#### **Dashboard Controls**

The Dashboard screen includes helpful controls in the app bar:

| Button | Function |
|--------|----------|
| **🔄 Refresh** | Reload the dashboard |
| **ℹ️ Info** | View current connection details and help |

**Configure Server URL:**
1. Go to **Settings tab** (⚙️ in bottom navigation)
2. Tap **"Server URL"** under Dashboard section
3. Enter your custom server address
4. Tap **"Save"**

**Settings Dialog Features:**
- ✅ Enter custom server URL
- ✅ "Use Default" button to reset to platform default
- ✅ Helpful examples and instructions
- ✅ Changes apply immediately - Dashboard reloads automatically
- ✅ BLoC-managed state with SettingsCubit
- ✅ Settings persist across app launches

### Troubleshooting:

#### **Emulator/Simulator Issues:**

1. **"Failed to Load Dashboard"**
   - Ensure Angular server is running: `cd webpage/internal-tools && npm start`
   - Check server logs for errors
   - Tap "Retry" button in the error screen

2. **Android Emulator Connection Failed**
   - Verify server is running on port 4200
   - `http://10.0.2.2:4200` is the correct emulator URL
   - Try restarting the emulator

3. **iOS Simulator Connection Failed**
   - Verify server is running: `curl http://localhost:4200`
   - Check for port conflicts (kill process using port 4200)

#### **Physical Device Issues:**

1. **"Unable to connect to dashboard server"**
   - ✅ **Same WiFi**: Phone and PC must be on the same network
   - ✅ **Correct IP**: Double-check your PC's IP address hasn't changed
   - ✅ **Server Running**: Verify Angular server is running
   - ✅ **Firewall**: Allow incoming connections on port 4200
   - ✅ **Test in Browser**: Open `http://YOUR_IP:4200` in phone's browser first

2. **Find your IP (detailed):**
   
   **Windows:**
   ```bash
   ipconfig
   # Look for "Wireless LAN adapter Wi-Fi" → "IPv4 Address"
   # Example: 192.168.1.100
   ```
   
   **Mac:**
   ```bash
   # Option 1: System Preferences
   System Preferences → Network → Select Wi-Fi → Advanced → TCP/IP → IPv4 Address
   
   # Option 2: Terminal
   ipconfig getifaddr en0
   ```
   
   **Linux:**
   ```bash
   ip addr show | grep "inet " | grep -v 127.0.0.1
   # Or: hostname -I
   ```

3. **Firewall Configuration:**

   **Windows Firewall:**
   - Control Panel → Windows Defender Firewall → Advanced Settings
   - Inbound Rules → New Rule → Port → TCP 4200 → Allow
   
   **Mac Firewall:**
   - System Preferences → Security & Privacy → Firewall → Firewall Options
   - Ensure Node.js is allowed
   
   **Linux (ufw):**
   ```bash
   sudo ufw allow 4200/tcp
   ```

4. **Test Connection:**
   ```bash
   # On your PC, find external-facing IP:
   # Windows: ipconfig
   # Mac/Linux: ifconfig | grep "inet "
   
   # Test from phone's browser:
   # Open: http://YOUR_IP:4200
   # Should see Angular dashboard
   ```

5. **Rebuild After Configuration:**
   - After changing `customServerUrl`, you **must rebuild** the app
   ```bash
   cd flutter_app
   flutter clean
   flutter build apk --release
   ```

#### **General Tips:**

- Use the **info button (ℹ️)** in the Dashboard tab to see current connection URL
- Check error screen for detailed setup instructions
- The error screen shows the exact URL being used
- Use "Retry" button after fixing issues

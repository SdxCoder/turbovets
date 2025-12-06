# Physical Device Setup Guide

This guide explains how to configure the app to access the Internal Tools Dashboard on a **physical phone/tablet**.

> **🎉 NEW: No Code Changes Required!**  
> The app now supports **in-app server configuration**. Just install the APK and configure the server URL from the settings dialog!

## 📱 Quick Setup (4 Steps - No Rebuild!)

### Step 1: Find Your Computer's IP Address

#### Windows
```bash
ipconfig
```
Look for **"IPv4 Address"** under your WiFi adapter
Example: `192.168.1.100`

#### Mac
```bash
ipconfig getifaddr en0
```
Or: System Preferences → Network → Wi-Fi → Advanced → TCP/IP

#### Linux
```bash
hostname -I
```
Or: `ip addr show | grep "inet "`

---

### Step 2: Start Angular Server

```bash
cd webpage/internal-tools
npm start
```

Server will run on `http://0.0.0.0:4200` (accessible from network)

---

### Step 3: Configure Firewall

Allow incoming connections on **port 4200**:

#### Windows
1. Control Panel → Windows Defender Firewall → Advanced Settings
2. Inbound Rules → New Rule
3. Port → TCP → 4200 → Allow

#### Mac
1. System Preferences → Security & Privacy → Firewall
2. Firewall Options → Ensure Node.js is allowed

#### Linux
```bash
sudo ufw allow 4200/tcp
```

---

### Step 4: Install APK and Configure in App

**Install APK:**
```
flutter_app/build/app/outputs/flutter-apk/app-release.apk
```
Transfer to your phone and install (use existing APK - no rebuild needed!)

**Configure Server:**
1. Open the app and navigate to **Dashboard tab**
2. Tap the **settings icon (⚙️)** in the app bar
3. Enter your server URL: `http://192.168.1.100:4200` (use YOUR IP)
4. Tap **"Save & Reload"**
5. Dashboard should load!

---

## ✅ Testing Connection

### Before Installing APK:

1. **Check your IP hasn't changed:**
   - WiFi routers often assign dynamic IPs
   - Re-run IP check command if connection fails

2. **Test in phone's browser first:**
   - Connect phone to same WiFi network
   - Open: `http://YOUR_IP:4200` in Chrome/Safari
   - You should see the Angular dashboard
   - If this doesn't work, the Flutter app won't work either

3. **Verify server is running:**
   ```bash
   curl http://localhost:4200
   # Should return HTML
   ```

---

## 🔧 Troubleshooting

### "Failed to Load Dashboard" in App

**Checklist:**
- [ ] Phone and PC on same WiFi network
- [ ] Angular server is running (`npm start`)
- [ ] Firewall allows port 4200
- [ ] Used correct IP in `customServerUrl`
- [ ] Rebuilt app after changing configuration
- [ ] Tested URL in phone's browser first

### Android: ERR_CLEARTEXT_NOT_PERMITTED

If you see this error, Android is blocking HTTP traffic (security feature).

**Solution**: The app is already configured with network security settings:
- `android/app/src/main/res/xml/network_security_config.xml` - Allows HTTP for localhost/local IPs
- `AndroidManifest.xml` - Has `usesCleartextTraffic="true"` and `networkSecurityConfig`

**If still failing**:
1. Clean and rebuild:
   ```bash
   cd flutter_app
   flutter clean
   flutter build apk --release
   ```
2. Ensure your local IP is in the allowed range (192.168.x.x, 10.0.x.x)

### Connection Refused

```bash
# Check if server is listening on all interfaces:
netstat -an | grep 4200
# Should show: 0.0.0.0:4200 or *:4200

# If not, ensure Angular is configured correctly:
# Check: webpage/internal-tools/angular.json
# Should have: "host": "0.0.0.0"
```

### Firewall Blocking

**Test firewall:**
```bash
# From another device on same network:
telnet YOUR_IP 4200
# Should connect successfully
```

**Temporarily disable firewall to test:**
- If connection works with firewall off, add rule for port 4200

### IP Address Changed

If your computer's IP changes (common with DHCP):

1. **Find new IP** (Step 1)
2. **Open app → Dashboard tab → Settings icon (⚙️)**
3. **Enter new URL**
4. **Tap "Save & Reload"**

**No rebuild needed!** Just update in the app.

**Tip:** Configure static IP on your router to prevent this

---

## ⚙️ In-App Server Configuration

The app includes a **built-in settings dialog** for easy server configuration:

### How to Access:
1. Open the app
2. Navigate to **Dashboard tab**
3. Tap the **settings icon (⚙️)** in the app bar

### Features:
- ✅ **Dynamic URL entry**: Enter any server URL
- ✅ **Platform-specific defaults**: Shows correct defaults for your device
- ✅ **Helpful hints**: Examples and instructions included
- ✅ **Instant reload**: Changes apply immediately
- ✅ **Persistent**: Settings saved locally using Hive
- ✅ **Reset option**: "Use Default" button to revert

### Configuration Dialog Includes:
- Text field to enter server URL
- Default URL examples for different platforms
- Setup instructions for physical devices
- Validation and helpful error messages

### No Rebuild Required!
- Change server URL anytime
- Test multiple servers
- Switch between emulator and physical device
- Perfect for development and testing

---

## 🎯 Alternative: USB Debugging

If WiFi setup is problematic, use **ADB port forwarding**:

### Android (ADB Method)

1. **Enable USB debugging on phone**
2. **Connect via USB**
3. **Forward port:**
   ```bash
   adb reverse tcp:4200 tcp:4200
   ```
4. **Keep `customServerUrl = ''`** (use default)
5. **Use `http://localhost:4200`** in app

This makes your PC's `localhost:4200` available as `localhost:4200` on the phone.

---

## 📖 Additional Resources

- **Main README**: `README.md` - Full project documentation
- **Assessment Plan**: `ASSESSMENT_PLAN.md` - Project requirements
- **Angular Setup**: `webpage/internal-tools/README.md` - Angular configuration

---

## 🆘 Still Having Issues?

### In-App Help

The Dashboard screen has an **info button (ℹ️)** that shows:
- Current connection URL
- Platform information
- Setup instructions

### Error Screen

If connection fails, the error screen displays:
- Current URL being used
- Platform-specific instructions
- Retry button

### Connection Info

Tap the **info icon** in the Dashboard tab's app bar for detailed connection information.

---

## ✨ Success Indicators

You'll know it's working when:
1. ✅ Phone's browser loads `http://YOUR_IP:4200`
2. ✅ Dashboard tab shows loading spinner briefly
3. ✅ Angular dashboard appears in the app
4. ✅ All three modules (Tickets, Knowledgebase, Logs) are functional
5. ✅ Navigation within dashboard works smoothly

---

**Note:** For development with emulator/simulator, no configuration is needed. See main README for details.


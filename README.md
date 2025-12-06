# TurboVets Chat

A Flutter messaging application with intelligent auto-reply agent, real-time chat updates, and image sharing capabilities.

## Project Structure

```
/
├── flutter_app/       # Flutter messaging interface
├── webpage/           # Angular + Tailwind Internal Tools Dashboard (Coming soon)
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
5. **Settings**: Tap profile icon → Change theme or logout

## Architecture

Built with **Clean Architecture** principles:
- **Presentation Layer**: BLoC for state management, AutoRoute for navigation
- **Domain Layer**: Pure Dart business logic with use cases
- **Data Layer**: Hive for local storage, DTOs for data transfer

## Tech Stack

- **State Management**: flutter_bloc
- **Dependency Injection**: get_it + injectable
- **Navigation**: auto_route
- **Local Storage**: Hive
- **Image Handling**: image_picker, cached_network_image

## Platform-Specific Notes

### iOS
- Photo library permission is configured in `Info.plist`
- WebView support enabled (for future Internal Tools Dashboard)

### Android
- Network permissions configured for WebView access
- Use `http://10.0.2.2:PORT` for localhost access in emulator

## Coming Soon

- **Internal Tools Dashboard**: Angular + Tailwind web app embedded via WebView
  - Ticket Viewer
  - Knowledgebase Editor
  - Live Logs Panel

# 🎨 Icon Atelier - Custom App Icons

Icon Atelier is a premium, feature-rich Flutter application designed to give users full control over their mobile home screen aesthetics. It allows users to browse installed applications and create custom shortcuts with personalized icons.

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)

## ✨ Features

- **📱 App Customizer**: Browse all installed applications on your device.
- **🎨 Shortcut Creator**: Create custom shortcuts for any app with a personalized name and icon.
- **✨ Animated Splash Screen**: A beautiful, high-quality Lottie animation greets users upon startup.
- **🌙 Dark Mode Support**: Sleek, premium dark theme optimized for eye comfort and battery saving.
- **🌐 Multilingual (RTL Support)**: Full support for English and Arabic with automatic layout adjustment.
- **⚡ Clean Architecture**: Built using a robust, maintainable architecture with BLoC for state management.

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev)
- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it)
- **Animations**: [Lottie](https://pub.dev/packages/lottie)
- **Storage**: [shared_preferences](https://pub.dev/packages/shared_preferences)
- **Icons**: [iconsax_flutter](https://pub.dev/packages/iconsax_flutter)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Android Studio / VS Code
- An Android device or emulator (required for app listing and shortcut features)

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Mohamedelsammn/Icon-Atelier.git
   ```

2. **Navigate to the project directory**:
   ```bash
   cd Icon-Atelier
   ```

3. **Install dependencies**:
   ```bash
   flutter pub get
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```

## ⚠️ Important Note

Currently, the core features of this app (listing installed apps and creating shortcuts) are **exclusive to Android**. Due to platform restrictions on iOS, these features are implemented via Android-specific platform channels.

## 📄 License

This project is for demonstration purposes. All rights reserved.

---
Developed with ❤️ by [Mohamed Elsammn](https://github.com/Mohamedelsammn)

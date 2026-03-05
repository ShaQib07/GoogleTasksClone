# Google Tasks Clone

A clean and functional clone of the Google Tasks mobile application, built with Flutter. This project demonstrates modern Flutter development practices, including Clean Architecture, BLoC for state management, and a local reactive database with Drift.

## 🚀 Features

- **Task Management**: Create, view, and organize your tasks.
- **Multiple Lists (Tabs)**: Categorize tasks into different lists using a tabbed interface.
- **Reactive UI**: Immediate updates across the app when data changes.
- **Local Persistence**: All your tasks are saved locally on your device.
- **Clean UI**: A faithful recreation of the Material Design 3 Google Tasks interface.

## 🛠 Tech Stack

- **Framework**: [Flutter](https://flutter.dev)
- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- **Local Database**: [Drift](https://drift.simonbinder.eu/) (formerly moor) - a reactive persistence library.
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it) with [injectable](https://pub.dev/packages/injectable).
- **Navigation**: [auto_route](https://pub.dev/packages/auto_route) for strongly-typed routing.
- **Code Generation**: [Freezed](https://pub.dev/packages/freezed) for immutable data classes and [build_runner](https://pub.dev/packages/build_runner).

## 🏗 Architecture

The project follows **Clean Architecture** principles to ensure scalability, maintainability, and testability:

- **Domain Layer**: Contains Entities, Repository interfaces, and Use Cases. (Pure Dart)
- **Data Layer**: Implements Repositories and handles data sources (Drift database, Shared Preferences).
- **Presentation Layer**: UI logic using the BLoC pattern, Widgets, and Pages.
- **DI (Dependency Injection)**: Centralized configuration using `injectable`.

## 📦 Getting Started

### Prerequisites

- Flutter SDK (check `pubspec.yaml` for version)
- Android Studio / VS Code

### Installation

1.  **Clone the repository**
    ```bash
    git clone https://github.com/your-username/google_tasks_clone.git
    cd google_tasks_clone
    ```

2.  **Install dependencies**
    ```bash
    flutter pub get
    ```

3.  **Run code generation**
    This project uses `build_runner` for Drift, Injectable, and AutoRoute.
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the app**
    ```bash
    flutter run
    ```

## 📂 Project Structure

```text
lib/
├── data/              # Data Layer (Implementations)
│   ├── database/      # Local Drift database & table definitions
│   ├── mappers/       # Entity <-> Model mapping logic
│   ├── models/        # Data-specific models (DTOs)
│   └── repositories/  # Repository implementations
├── domain/            # Business Logic (Pure Dart)
│   ├── entities/      # Core business objects
│   ├── repositories/  # Abstract repository interfaces
│   └── usecases/      # Application-specific business rules
├── presentation/      # UI Layer
│   └── screens/       # Feature-based screens (Task, Dashboard, etc.)
│       └── [feature]/ # Screen UI and feature-specific Cubits/Blocs
├── di/                # Dependency Injection setup (Injectable)
├── routes/            # Navigation routing (AutoRoute)
├── resources/         # App constants, assets, and themes
├── app.dart           # Root application widget
└── main.dart          # Entry point
```

## 📝 License

This project is open source. Feel free to use it as a reference for your own Flutter apps.

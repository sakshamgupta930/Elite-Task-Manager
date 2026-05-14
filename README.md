# Elite Task Manager 🚀

Elite Task Manager is a premium, high-performance to-do application built with Flutter, following **Clean Architecture** principles and powered by **GetX** for state management and dependency injection.

![Elite Task Manager Mockup](C:\Users\asus\.gemini\antigravity\brain\e9150f2c-c3d8-49d6-85ce-62695303fd6b\elite_task_manager_mockup_1778751855178.png)

## ✨ Features

- **Clean & Modern UI**: A premium user interface with smooth animations and a professional color palette.
- **Clean Architecture**: Decoupled layers (Domain, Data, Presentation) for maximum maintainability and testability.
- **GetX Power**: Efficient state management, dependency injection, and routing.
- **Local Persistence**: Tasks are saved locally using `get_storage`, ensuring your data is always available offline.
- **Productivity Insights**: Visualize your progress with interactive charts and goal tracking.
- **Task Management**: Create, toggle, and delete tasks with ease. Support for categories and priorities.
- **Responsive Design**: Optimized for a seamless experience across Android and iOS.

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [GetX](https://pub.dev/packages/get)
- **Local Storage**: [GetStorage](https://pub.dev/packages/get_storage)
- **Animations**: [Flutter Animate](https://pub.dev/packages/flutter_animate)

## 🏗️ Architecture

The project follows the **Clean Architecture** pattern to ensure a scalable and maintainable codebase:

- **Domain Layer**: Contains Entities, Repositories (interfaces), and Use Cases. This is the core business logic.
- **Data Layer**: Contains Models, Repositories (implementations), and Data Sources (GetStorage).
- **Presentation Layer**: Contains Screens (UI), Controllers (GetX), Bindings, and Widgets.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest version recommended)
- Android Studio / VS Code
- Git

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/sakshamgupta930/Elite-Task-Manager.git
   ```

2. Navigate to the project directory:
   ```bash
   cd Elite-Task-Manager
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```


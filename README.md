# Flutter Clean Architecture with Bloc

This Flutter application follows the Clean Architecture principles and utilizes the Bloc pattern for state management. The app fetches daily news from the News API, displays them, and provides the option to save news articles to a local SQLite database.

## Architecture Overview

The project follows the Clean Architecture principles, separating the app into different layers:

- **Presentation Layer**: Contains the Flutter widgets, Blocs, and UI-related logic.
- **Domain Layer**: Contains business logic and use cases.
- **Data Layer**: Manages data sources such as APIs and local databases.

![Architecture](images/project_architecture.png?raw=true)

## Features

1. Architecture: Clean Architecture
2. State management: [flutter_bloc](https://pub.dev/packages/flutter_bloc)
3. Navigation: IFlutterNavigator
4. DI: [get_it](https://pub.dev/packages/get_it), [injectable](https://pub.dev/packages/injectable)
5. REST API: [http](https://pub.dev/packages/http)
6. Database: [get storage](https://pub.dev/documentation/get_storage/latest/)
7. Shared Preferences: [encrypted_shared_preferences](https://pub.dev/packages/encrypted_shared_preferences)
8. Lint: [dart_code_metrics](https://pub.dev/packages/dart_code_metrics), [flutter_lints](https://pub.dev/packages/flutter_lints)
9. Paging: [infinite_scroll_pagination](https://pub.dev/packages/infinite_scroll_pagination)
10. Assets generator: [flutter_build_runner](https://pub.dev/packages/build_runner), [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons), [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)
11. Custom Dropdown with search and Tag
12. Dynamic page build by REST API
13. Chart
14. Global Error Handling

## State Management

The app uses the Bloc pattern for state management. Blocs are responsible for managing the application's state and business logic.

## Service Locator

The `get_it` package is used as a service locator for dependency injection. It helps manage the app's dependencies in a clean and organized way.

## API Requests

http is used for making API requests to the APIs. It provides a type-safe way to interact with RESTful APIs.

## Dart Object Comparison

The `equatable` package is employed for efficient comparison of Dart objects. This is particularly useful when working with Blocs and state changes.

## Local Database

The app uses Get Storage. Data can be saved to the local database for offline access.

## Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/alfaruk16/work_diary.git

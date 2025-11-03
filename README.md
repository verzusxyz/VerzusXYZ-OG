# VerzusXYZ: A Firebase-Powered Gaming Application

**VerzusXYZ** is a versatile and engaging Flutter-based gaming application that offers a variety of interactive games for users. This repository contains the complete source code for the application, which is built with Flutter and deeply integrated with Firebase for its backend services.

## Project Overview

This repository serves as a comprehensive example of a Flutter application that has been migrated to use Firebase for its core backend infrastructure. The application provides a seamless and enjoyable gaming experience, with features such as user authentication, a variety of games, real-time updates, and in-app purchases.

The primary purpose of this repository is to serve as a developer onboarding guide for understanding and working with a Flutter application that leverages the full power of the Firebase suite.

## Architecture Summary

The application's architecture is designed to be modular and scalable, with a clear separation of concerns. The codebase is organized into the following key directories:

- **`lib/core`**: Contains the core components of the application, including dependency injection setup, routing, and utility classes.
- **`lib/data`**: The data layer of the application, which includes models, repositories, services, and controllers. This is where the majority of the Firebase integration logic resides.
- **`lib/view`**: The presentation layer of the application, containing all the UI components, screens, and widgets.

The application is built using the **GetX** package for state management, dependency injection, and routing, which provides a lightweight and powerful framework for building reactive applications.

### Firebase Backend Architecture

The application uses a full Firebase backend, with the following services and data model:

- **Firebase Authentication**: For user sign-up, sign-in, and social login.
- **Firebase Cloud Firestore**: As the primary database for storing user data, game state, and other application data.
- **Firebase Cloud Storage**: For storing user-generated content, such as profile pictures and game assets.
- **Firebase Cloud Messaging (FCM)**: For sending push notifications to users to keep them engaged with the application.

#### Firestore Data Model

The Firestore database is structured as follows:

- **`users` collection**: Stores user-specific data.
  - **`uid`**: The user's unique ID from Firebase Authentication.
  - **`firstName`**: The user's first name.
  - **`lastName`**: The user's last name.
  - **`email`**: The user's email address.
  - **`reference`**: A referral code, if applicable.
  - **`balance`**: The user's current balance.
- **`games` collection**: Stores information about the available games.
  - **`gameId`**: A unique ID for the game.
  - **`name`**: The name of the game.
  - **`minBet`**: The minimum bet for the game.
  - **`maxBet`**: The maximum bet for the game.
- **`gameLogs` collection**: Stores a log of all games played by users.
  - **`gameLogId`**: A unique ID for the game log.
  - **`userId`**: The ID of the user who played the game.
  - **`gameId`**: The ID of the game that was played.
  - **`invest`**: The amount of money the user invested in the game.
  - **`result`**: The result of the game.
  - **`winStatus`**: The user's win status for the game.
  - **`createdAt`**: The timestamp of when the game was played.

## Setup Instructions

To get started with the VerzusXYZ application, follow these steps to set up your development environment:

### Prerequisites

- **Flutter**: Ensure you have the latest version of the Flutter SDK installed. You can find instructions on how to do this on the [official Flutter website](https://flutter.dev/docs/get-started/install).
- **Firebase CLI**: Install the Firebase command-line interface (CLI) to interact with your Firebase project. You can find instructions on how to do this on the [official Firebase documentation](https://firebase.google.com/docs/cli).

### 1. Clone the Repository

Clone this repository to your local machine using the following command:

```bash
git clone https://github.com/your-username/verzusxyz.git
```

### 2. Set Up Firebase

1. **Create a Firebase Project**: Go to the [Firebase console](https://console.firebase.google.com/) and create a new project.
2. **Add Flutter Apps**: Add an Android and iOS app to your Firebase project. Follow the on-screen instructions to download the `google-services.json` and `GoogleService-Info.plist` files.
3. **Place Configuration Files**:
   - Place the `google-services.json` file in the `android/app` directory.
   - Place the `GoogleService-Info.plist` file in the `ios/Runner` directory.
4. **Enable Firebase Services**: In the Firebase console, enable the following services:
   - **Authentication**: Enable the Email/Password and social login providers (e.g., Google, Facebook) that you want to support.
   - **Cloud Firestore**: Create a new Firestore database.
   - **Cloud Storage**: Create a new Storage bucket.

### 3. Install Dependencies

Once you have cloned the repository and set up Firebase, you can install the required dependencies by running the following command in the root of the project:

```bash
flutter pub get
```

### 4. Run the Application

You can now run the application on an emulator or a physical device using the following command:

```bash
flutter run
```

## Migration Steps

This repository has already been migrated to use Firebase. However, if you are interested in the steps that were taken to perform the migration, here is a high-level overview:

1. **Firebase Integration**: The first step was to integrate the Firebase SDKs for Flutter into the application. This involved adding the necessary dependencies to the `pubspec.yaml` file and initializing Firebase in the `main.dart` file.
2. **Authentication Migration**: The existing authentication system was replaced with Firebase Authentication. This involved rewriting the login, registration, and social login logic to use the Firebase Authentication APIs.
3. **Database Migration**: The application's data was migrated from the previous database to Firebase Cloud Firestore. This involved creating a new data model that was compatible with Firestore and writing scripts to migrate the data.
4. **Storage Migration**: The's file storage was migrated to Firebase Cloud Storage. This involved updating the file upload and download logic to use the Firebase Storage APIs.
5. **Push Notification Migration**: The push notification system was migrated to Firebase Cloud Messaging. This involved setting up FCM in the Firebase console and rewriting the push notification handling logic in the application.

## Usage Examples

Here are some examples of how to use the application:

- **Running Tests**: To run the unit and widget tests, use the following command:
  ```bash
  flutter test
  ```
- **Building the Application**: To build the application for release, use the following command:
  ```bash
  flutter build <platform>
  ```
  Replace `<platform>` with either `apk` or `appbundle` for Android, or `ios` for iOS.

## Troubleshooting & Common Issues

Here are some common issues you may encounter and how to resolve them:

- **Firebase Initialization Error**: If you encounter an error related to Firebase initialization, ensure that you have correctly placed the `google-services.json` and `GoogleService-Info.plist` files in the correct directories.
- **Missing Dependencies**: If you encounter an error about missing dependencies, run `flutter pub get` to ensure that all the required packages are installed.
- **Platform-Specific Issues**: If you encounter any platform-specific issues, refer to the official Flutter and Firebase documentation for guidance.

## Contribution Guidelines

We welcome contributions to the VerzusXYZ project! If you would like to contribute, please follow these guidelines:

1. **Fork the Repository**: Fork this repository to your own GitHub account.
2. **Create a New Branch**: Create a new branch for your feature or bug fix.
3. **Make Your Changes**: Make your changes to the codebase, ensuring that you follow the existing coding style and conventions.
4. **Write Tests**: Write unit and widget tests for your changes to ensure that they are working correctly.
5. **Submit a Pull Request**: Submit a pull request to the `main` branch of this repository.

We look forward to your contributions!

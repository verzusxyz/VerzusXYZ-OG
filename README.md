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
- **Firebase Cloud Functions**: For secure, server-side logic, such as payment processing.

#### Firestore Data Model

The Firestore database is structured as follows:

- **`users` collection**: Stores user-specific data.
  - **`uid`**: The user's unique ID from Firebase Authentication.
  - **`firstName`**: The user's first name.
  - **`lastName`**: The user's last name.
  - **`email`**: The user's email address.
  - **`reference`**: A referral code, if applicable.
  - **`liveBalance`**: The user's live wallet balance.
  - **`demoBalance`**: The user's demo wallet balance.
- **`games` collection**: Stores information about the available games.
- **`gameLogs` collection**: Stores a log of all games played by users.
- **`settings` collection**: Stores global application settings.
- **`paymentGateways` collection**: Stores the configuration for payment gateways.

## Admin Management

The Firebase backend is designed to be managed by an administrator through the Firebase console or a custom admin panel.

### Managing Global Settings

The global settings for the application are stored in the `settings` collection in Firestore, in a single document named `global`. You can edit this document to change the application's behavior in real-time. The available settings are:

- **`needAgreePolicy`** (boolean): If `true`, new users must agree to the terms and conditions before registering.
- **`checkPasswordStrength`** (boolean): If `true`, new users must create a strong password that meets certain criteria.

### Managing Payment Gateways

The payment gateways are managed in the `paymentGateways` collection in Firestore. Each document in this collection represents a payment gateway and has the following fields:

- **`name`** (string): The name of the payment gateway (e.g., "Stripe", "PayPal").
- **`logoUrl`** (string): A URL for the gateway's logo.
- **`isActive`** (boolean): A toggle to show or hide the gateway in the app.
- **`providerId`** (string): A unique ID for the gateway (e.g., "stripe", "paypal").

To add a new payment gateway, you will need to:

1.  Add a new document to the `paymentGateways` collection with the required fields.
2.  Store the gateway's secret API key in **Google Secret Manager**.
3.  Update the `createCheckoutSession` Cloud Function to include the logic for the new gateway.

## Setup Instructions

To get started with the VerzusXYZ application, follow these steps to set up your development environment:

### Prerequisites

- **Flutter**: Ensure you have the latest version of the Flutter SDK installed.
- **Firebase CLI**: Install the Firebase command-line interface (CLI).

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/verzusxyz.git
```

### 2. Set Up Firebase

1.  Create a Firebase project and add an Android and iOS app.
2.  Place the `google-services.json` and `GoogleService-Info.plist` files in the correct directories.
3.  Enable Firebase Authentication, Cloud Firestore, Cloud Storage, and Cloud Functions.
4.  Deploy the Cloud Functions located in the `functions` directory.

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Run the Application

```bash
flutter run
```

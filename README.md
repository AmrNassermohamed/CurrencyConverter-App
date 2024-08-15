Currency Converter App

Overview

A Flutter application that allows users to convert currencies, view historical data, and manage a list of supported currencies with their flags. The app uses Dio for HTTP requests and follows the BLoC pattern for state management.

Instructions

Prerequisites

	•	Flutter SDK
	•	Dio
	•	Flutter Bloc
	•	SQLite for local database

Getting Started

	1.	Clone the Repository:
              git clone <repository-url>
              cd <repository-name>
	2.	Install Dependencies:
           Run flutter pub get to install the required dependencies.
           flutter pub get
    3.	Build and Run the App:
	     Make sure to have an emulator or physical device connected.

Architecture

Design Pattern

Adapted Design Pattern: BLoC (Business Logic Component)

Justification:

	•	Separation of Concerns: BLoC helps separate business logic from UI code, making it easier to manage and test.
	•	Scalability: The BLoC pattern scales well with complex applications by breaking down state management into distinct components.
	•	Testability: BLoC allows for easier unit testing of business logic and state transitions, improving code reliability.

Image Loader Library

Adapted Library: Dio

Justification:

	•	HTTP Requests: Dio is a powerful HTTP client for Dart that supports interceptors, global configuration, and form data, which is useful for making API requests to fetch currency data and flags.
	•	Error Handling: Dio provides comprehensive error handling, which helps manage different types of network errors gracefully.
	•	Performance: Dio is designed to handle high-performance scenarios efficiently.

Database

Used Database: SQLite (via sqflite)

Justification:

	•	Local Storage: SQLite allows for local data storage, which is necessary for caching the list of supported currencies and their flags to improve app performance and reduce API calls.
	•	Ease of Use: The sqflite package provides a straightforward API for interacting with SQLite databases in Flutter.
	•	Data Persistence: Ensures data persistence across app restarts, which is crucial for maintaining a local cache of currency data.

Testing

Running Tests

To run unit tests and widget tests:
flutter testEnsure all tests pass before deploying or sharing the app.

Writing Tests

	•	BLoC Tests: Located in test/bloc/, these tests validate the state management logic and event handling in the BLoCs.
	•	Repository Tests: Located in test/data/, these tests ensure the repository correctly handles API requests and responses.
	•	UI Tests: Located in test/screens/, these tests check the functionality and appearance of the app’s screens.

Contributing

Feel free to open issues or submit pull requests. For major changes, please open an issue first to discuss what you would like to change.

License

This project is licensed under the MIT License - see the LICENSE file for details.

Replace <repository-url> and <repository-name> with your actual repository URL and name. This README provides a comprehensive overview of the project, its architecture, and how to get started.# CurrencyConverter-App

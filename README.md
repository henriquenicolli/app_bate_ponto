# Electronic Time Clock Mobile App

This project was developed to learn more about Flutter and implement an electronic time clock app that communicates with a REST API. The app is cross-platform, working on **Android**, **iOS**, and **Desktop**.

## Features

- **Time Clock**: Users can clock in and out directly from the app.
- **REST API Integration**: The app communicates with an API to log the clock entries, ensuring synchronization across devices.
- **Supported Platforms**: Android, iOS, and Desktop (Windows, Linux, macOS).

## Technologies Used

- **Flutter**: The main framework for cross-platform development.
- **Dart**: The programming language used with Flutter.
- **REST API**: For communication between the app and the backend.
- **SQLite / SharedPreferences**: For local storage on the device.
  
## Prerequisites

Before running the project, ensure you have the following installed on your machine:

- **Flutter**: For mobile and desktop app development.
  - Follow the [official Flutter installation guide](https://flutter.dev/docs/get-started/install) to install Flutter on your machine.
  
- **Android Studio** or **VS Code**: To edit the code and run the app on Android.
  
- **Xcode** (only for iOS): If you're developing for iOS, you will need Xcode, available only on macOS.

## Running the Project

### Android / iOS

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/electronic-time-clock.git
    cd electronic-time-clock
    ```

2. Open the project in your preferred code editor (Android Studio or VS Code).

3. Install the dependencies:
    ```bash
    flutter pub get
    ```

4. Connect an Android/iOS device or use an emulator/simulator.

5. Run the project:
    ```bash
    flutter run
    ```

### Desktop (Windows, Linux, macOS)

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/electronic-time-clock.git
    cd electronic-time-clock
    ```

2. Open the project in your code editor.

3. Install the dependencies:
    ```bash
    flutter pub get
    ```

4. Run the project on your desktop:
    ```bash
    flutter run -d windows  # For Windows
    flutter run -d macos    # For macOS
    flutter run -d linux    # For Linux
    ```

## Project Structure

- `lib/`: Contains the main Dart files of the app.
  - `main.dart`: The entry point of the app.
  - `screens/`: Contains the main screens of the app.
  - `services/`: Contains the services for API communication.
  - `models/`: Contains the model classes for the data the app uses.
  
- `assets/`: Contains images and other resources used by the app.

## Libraries Used

This project uses several libraries to implement its features:

### `timezone: ^0.9.2`
- **Usage**: This library is used to handle time zone conversion, ensuring that time entries are logged with the correct time zone information.

### `flutter: sdk: flutter`
- **Usage**: The main SDK for developing cross-platform applications with Flutter, providing all necessary tools and widgets.

### `cupertino_icons: ^1.0.2`
- **Usage**: Provides icons for iOS-style applications.

### `http: ^1.2.0`
- **Usage**: Used to make HTTP requests to the REST API for logging time entries.

### `flutter_map: ^6.0.0`
- **Usage**: A flexible and customizable map widget that allows the display of maps in the app.

### `latlong2: ^0.9.0`
- **Usage**: Used in conjunction with `flutter_map` to handle geographical coordinates (latitude and longitude) for location-based features.

### `location: ^5.0.3`
- **Usage**: Used to access the device's location to record the GPS coordinates during clock-in and clock-out actions.

### `platform: ^3.0.0`
- **Usage**: Provides platform-specific code for handling Android, iOS, and desktop behaviors.

### `dio: ^5.4.3+1`
- **Usage**: A powerful HTTP client for making network requests with additional features like interceptors, global configuration, and more.

### `process_run: ^1.0.0+1`
- **Usage**: Used for running system processes and commands, particularly useful for platform-specific tasks that may require external scripts or commands.

### `shared_preferences: ^2.0.8`
- **Usage**: Used to store simple key-value pairs locally on the device, such as user preferences or last logged time.

### `connectivity: ^3.0.6`
- **Usage**: Used to check the device's network connectivity status to handle cases where the app needs to synchronize data when online.

## How to Contribute

If you'd like to contribute to this project, follow these steps:

1. Fork the repository.
2. Create a branch for your feature (`git checkout -b feature/feature-name`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to the remote repository (`git push origin feature/feature-name`).
5. Open a Pull Request.


## Author
This project was developed by **Henrique Biondo Nicolli Soares**.  
Feel free to reach out for collaboration or questions regarding the project!  

- GitHub: [henriquenicolli](https://github.com/henriquenicolli)  
- Email: henrique.nicolli@gmail.com
- LinkedIn: [Henrique Biondo Nicolli Soares](https://www.linkedin.com/in/henrique-biondo-nicolli-soares-4aa408106/)  

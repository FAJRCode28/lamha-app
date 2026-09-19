LAMHA | لمحة

عرف قبل ما تروح | Know Before You Go

 Project Idea

LAMHA is a Flutter application that helps users discover places and know useful information before visiting them.

The app provides information such as crowd level, parking availability, opening hours, family suitability, and nearby activities.

 Problem

People may visit a place without knowing whether it is crowded, whether parking is available, or whether the place is suitable for them.

LAMHA brings useful information together in one application to help users get a quick overview before they go.

 Target Users

LAMHA is designed for residents, visitors, and tourists who want to discover places and get useful information before visiting them.

 Features

- User registration and login
- Personalized user profile
- Discover places based on the selected city
- Search for places
- View place details
- Crowd and parking information
- Opening hours and family suitability
- Save favorite places
- View nearby places
- Open locations on maps
- Manage city and interests
- Notification preferences
- Suggest a new place
- Loading and error states with retry support

 Technologies Used

- Flutter
- Dart
- Supabase
- BLoC / Cubit
- Dio
- Geoapify API
- REST API

 Project Structure

The project uses a simple and organized structure with separate folders for:

- Screens
- Widgets
- Models
- Services
- Cubit and States
- Configuration

 API Configuration

The Geoapify API key is not stored directly in the source code.

Run the application using:

```bash
flutter run --dart-define=GEOAPIFY_API_KEY=YOUR_API_KEY

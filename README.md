LAMHA | لمحة 🇸🇦

### اعرف قبل ما تروح | Know Before You Go

LAMHA is a Flutter application that helps users discover places and know useful information before visiting them.

The app provides information about places such as crowd level, parking availability, opening hours, family suitability, and nearby activities.

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

Technologies Used

- Flutter
- Dart
- Supabase
- BLoC / Cubit
- Dio
- Geoapify API
- REST API

 Project Structure

The project is organized into separate folders for:

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

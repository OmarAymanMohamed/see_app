# Firebase Setup Instructions

This document provides detailed instructions for setting up Firebase for the SEE (Smart Emotional Enhancement) application. Follow these steps to configure Firebase Authentication and Cloud Firestore for the app.

## Prerequisites

- A Google account
- [Firebase CLI](https://firebase.google.com/docs/cli) (optional, for advanced features)
- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed
- An IDE (VS Code, Android Studio, etc.)

## Step 1: Create a Firebase Project

1. Go to the [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Enter a project name (e.g., "SEE-App-Dev" for development)
4. Choose whether to enable Google Analytics (recommended)
5. Follow the prompts to complete project creation

## Step 2: Configure Android App

1. In the Firebase Console, click on your project
2. Click the Android icon to add an Android app
3. Enter the Android package name: `com.example.see_app` (or your custom package name)
4. Enter an app nickname (optional, e.g., "SEE App")
5. Enter the SHA-1 debug signing certificate (optional for development, required for production)
6. Click "Register app"
7. Download the `google-services.json` file
8. Replace the template file at `android/app/google-services.json` with the downloaded file

## Step 3: Configure iOS App (if applicable)

1. In the Firebase Console, click on your project
2. Click the iOS icon to add an iOS app
3. Enter the iOS bundle ID (from your Xcode project)
4. Enter an app nickname (optional)
5. Click "Register app"
6. Download the `GoogleService-Info.plist` file
7. Add this file to your Xcode project (right-click Runner folder > Add Files to "Runner")

## Step 4: Enable Authentication

1. In the Firebase Console, go to "Build" > "Authentication"
2. Click "Get started"
3. Enable the "Email/Password" sign-in method
4. (Optional) Enable other authentication methods as needed

## Step 5: Create Firestore Database

1. In the Firebase Console, go to "Build" > "Firestore Database"
2. Click "Create database"
3. Choose "Start in production mode" or "Start in test mode" (for development)
4. Select a location for your database (choose the region closest to your users)
5. Click "Enable"

## Step 6: Set Up Database Security Rules

1. In the Firebase Console, go to "Build" > "Firestore Database" > "Rules"
2. Configure security rules based on your requirements. Here's a starting point:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, update, delete: if request.auth != null && request.auth.uid == userId;
      allow create: if request.auth != null;
    }
    match /children/{childId} {
      allow read, write: if request.auth != null && 
        exists(/databases/$(database)/documents/users/$(request.auth.uid)) &&
        get(/databases/$(database)/documents/users/$(request.auth.uid)).data.childrenIds.hasAny([childId]);
    }
    match /emotions/{emotionId} {
      allow read, write: if request.auth != null;
    }
    match /alerts/{alertId} {
      allow read, write: if request.auth != null;
    }
    match /suggestions/{suggestionId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && 
        exists(/databases/$(database)/documents/users/$(request.auth.uid)) &&
        get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == "therapist";
    }
  }
}
```

## Database Schema

The SEE app uses the following collections:

### Users Collection
- **Document ID**: Firebase Auth UID
- **Fields**:
  - `id`: String (Firebase Auth UID)
  - `email`: String
  - `name`: String
  - `role`: String ("parent", "therapist", or "admin")
  - `childrenIds`: Array of Strings
  - `createdAt`: Timestamp
  - `profileImage`: String (URL, optional)
  - `additionalInfo`: Map (optional)

### Children Collection
- **Document ID**: Auto-generated
- **Fields**:
  - `id`: String
  - `name`: String
  - `age`: Number
  - `avatar`: String (URL)
  - `additionalInfo`: Map (optional)

### Emotions Collection
- **Document ID**: Auto-generated
- **Fields**:
  - `id`: String
  - `childId`: String
  - `timestamp`: Timestamp
  - `intensity`: Number (1-10)
  - `type`: String ("joy", "sadness", "anger", "fear", "calm")
  - `notes`: String (optional)
  - `createdBy`: String (User ID)

### Alerts Collection
- **Document ID**: Auto-generated
- **Fields**:
  - `id`: String
  - `childId`: String
  - `timestamp`: Timestamp
  - `severity`: String ("low", "medium", "high")
  - `emotion`: String
  - `intensity`: Number
  - `notes`: String (optional)
  - `resolved`: Boolean
  - `resolvedBy`: String (User ID, optional)
  - `resolvedAt`: Timestamp (optional)

### Suggestions Collection
- **Document ID**: Auto-generated
- **Fields**:
  - `id`: String
  - `title`: String
  - `description`: String
  - `imageUrl`: String (URL, optional)
  - `category`: String
  - `createdBy`: String (User ID)
  - `approved`: Boolean
  - `approvedBy`: String (User ID, optional)

## Test Accounts

The app automatically creates these test accounts on first run:

1. **Parent Accounts**:
   - Email: `parent@example.com`, Password: `password123`
   - Email: `parent2@example.com`, Password: `password123`

2. **Therapist Accounts**:
   - Email: `therapist@example.com`, Password: `password123`
   - Email: `therapist2@example.com`, Password: `password123`

## Local Development with Firebase Emulator

For local development without affecting production data:

1. Install Firebase CLI: `npm install -g firebase-tools`
2. Login to Firebase: `firebase login`
3. Initialize Firebase: `firebase init`
4. Start the emulator: `firebase emulators:start`
5. Configure the app to use the emulator by adding in your initialization code:

```dart
// For Auth
await FirebaseAuth.instance.useEmulator('localhost', 9099);

// For Firestore
FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
```

## Multiple Environments (Development/Staging/Production)

For different environments:

1. Create separate Firebase projects (e.g., SEE-App-Dev, SEE-App-Prod)
2. Generate configuration files for each environment
3. Use Flutter flavors to switch between environments:
   - For Android: Configure build variants in `build.gradle`
   - For iOS: Configure schemes in Xcode

## Troubleshooting

- If authentication fails, check that you've enabled Email/Password sign-in method
- If write operations fail, check your security rules
- For SHA-1 certificate issues, run: `./gradlew signingReport` in the android directory
- For Flutter web, ensure you've added the Firebase SDK in index.html
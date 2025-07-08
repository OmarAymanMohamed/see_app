# SEE App - Smart Emotional Enhancement

An innovative mobile application designed to monitor and manage the emotional states of children with Down syndrome, providing real-time insights, personalized calming techniques, and collaborative tools for parents, caregivers, and therapists.

## Overview

SEE leverages simulated emotion detection to track emotional patterns in children with Down syndrome. The app provides specialized interfaces for both parents and therapists, enabling coordinated emotional support and personalized intervention strategies.

## Key Features

### Parent Interface
- **Emotion Trend Dashboard**: Visualizes emotional patterns over time with intuitive charts
- **Distress Alerts**: Real-time notifications when significant emotional distress is detected
- **Personalized Calming Suggestions**: Tailored activities to help children regulate emotions
- **Child Selection**: Ability to monitor multiple children from a single account

### Therapist Interface
- **Multi-Child Monitoring**: Observe and track emotional trends across all assigned children
- **Emotional Analytics**: Comparative data visualization across children or time periods
- **Therapy Recommendations**: Create and deliver personalized therapy plans based on emotional insights
- **Progress Tracking**: Monitor emotional development and therapy effectiveness over time

### Core Functionality
- **Simulated Emotion Detection**: Mock data generation to simulate real-time emotional monitoring
- **Secure Authentication**: Separate login flows for parents and therapists
- **Accessible Design**: High-contrast UI, large touch targets, and easy-to-read fonts
- **Child-Friendly Aesthetics**: Bright, comforting colors with a playful visual identity

## Technical Architecture

### User Interfaces
The app features two primary interfaces:
1. **Parent Interface**: Focused on day-to-day monitoring and intervention
2. **Therapist Interface**: Designed for professional analysis and therapy planning

### Data Models
- `Child`: Basic information about monitored children
- `EmotionData`: Records of emotional states with timestamps and intensity
- `DistressAlert`: Notifications for emotional distress events
- `CalmingSuggestion`: Activities to help children regulate emotions

### Services
- `EmotionService`: Simulates emotion detection and provides data retrieval methods

### UI Components
- Custom emotion visualization charts
- Accessible form elements with larger touch targets
- Visually distinct alert cards based on severity levels
- Child-friendly color scheme and typography

## Installation and Setup

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio or Xcode for deployment to physical devices

### Setup Instructions
1. Clone the repository:
   ```
   git clone https://github.com/yourusername/see_app.git
   ```

2. Navigate to the project directory:
   ```
   cd see_app
   ```

3. Get dependencies:
   ```
   flutter pub get
   ```

4. Run the app:
   ```
   flutter run
   ```

## Usage Guide

### Parent Account
1. Log in using parent credentials
2. Select a child to monitor from the dashboard
3. View emotion trends and any active distress alerts
4. Browse and apply calming suggestions when needed
5. Track progress over time through the visual reports

### Therapist Account
1. Log in using therapist credentials
2. Access the multi-child overview dashboard
3. Review emotional analytics across all children
4. Create and modify therapy recommendations
5. Monitor implementation effectiveness over time

## Future Enhancements

### Wearable Integration
- Integration with wearable sensors for real-time physiological data
- Custom hardware adaptation for children with special needs
- Syncing capabilities for offline data collection

### Machine Learning Expansion
- Emotion recognition through facial expression analysis
- Pattern recognition for emotional trigger identification
- Personalized intervention effectiveness prediction

### Extended Features
- Video consultation between parents and therapists
- Shared progress journal for collaborative support
- Customizable notification settings for different emotion thresholds

## Business Model

### Value Proposition
- Real-time emotional monitoring for improved interventions
- Data-driven therapy planning for better outcomes
- Enhanced communication between caregivers and therapists

### Target Users
- Parents and caregivers of children with Down syndrome
- Therapists and special education professionals
- Healthcare institutions and special education facilities

### Revenue Streams
- Freemium model with basic features and premium subscriptions
- Institutional licensing for healthcare providers
- Anonymized data insights for research (with appropriate consent)

## Contributing

This project welcomes contributions and suggestions. Please fork the repository and submit pull requests for any enhancements.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

For any inquiries, please contact the development team at dev@seeapp.com.

## Fixing Gemini API and Firebase Issues

If you encounter issues with the Gemini API or Firebase permissions, follow these instructions:

### Gemini API Issues

1. **API Key Configuration**:
   - The app uses the Gemini API for AI-powered features
   - Two services use the Gemini API:
     - `GeminiService`: For generating insights about Down syndrome
     - `AITherapistService`: For the AI Therapist chat feature
   - Both should use the same API key for consistency

2. **API Model Versions**:
   - The app uses these Gemini models:
     - `gemini-1.5-flash`: For text-based generation
     - `gemini-1.5-flash-vision`: For image analysis
   - If these models are unavailable, update them in the services

3. **Testing API Connectivity**:
   - Use the System Diagnostics tool to test API connectivity
   - Navigate to login screen → tap diagnostics icon
   - Test both Gemini API and AI Therapist API

4. **Troubleshooting Steps**:
   - Check if API keys are correct
   - Verify model names exist in Google AI Studio
   - Ensure API billing is enabled

### Firebase Permission Issues

Firebase permission denied errors are due to restrictive security rules. To fix:

1. Use the rules provided in the `firebase` directory
2. Follow instructions in `firebase/README.md` to deploy them
3. Test permissions using the System Diagnostics tool

## Running the App

1. Install dependencies:
   ```
   flutter pub get
   ```

2. Run the app:
   ```
   flutter run
   ```

## System Diagnostics

The app includes a diagnostic tool for troubleshooting:
1. Go to the login screen
2. Tap the diagnostics icon in the corner
3. Run tests for:
   - Gemini API
   - AI Therapist API
   - Firebase permissions
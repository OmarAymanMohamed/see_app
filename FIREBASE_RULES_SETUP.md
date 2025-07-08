# Firebase Security Rules Setup

This guide will help you set up Firebase security rules for the SEE app.

## Security Rules Overview

The security rules in `firestore.rules` provide the following permissions:

- **Test Collection**: Allows authenticated users to read and write (for diagnostic purposes)
- **Users Collection**: Allows authenticated users to read all users, but only update their own user document
- **Children Collection**: Allows parents to access only their children's data
- **Emotions/Alerts Collections**: Allows authenticated users to read and write
- **Public Collection**: Allows authenticated users to read public data
- **Suggestions Collection**: Allows all users to read, but only therapists can write

## Deploying Firebase Rules

### Option 1: Using Firebase Console

1. Go to the [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Click on "Firestore Database" in the left sidebar
4. Click on the "Rules" tab
5. Copy the contents of the `firestore.rules` file
6. Paste the rules into the editor
7. Click "Publish" to deploy the rules

### Option 2: Using Firebase CLI

If you have the Firebase CLI installed, you can deploy rules from the command line:

1. Install Firebase CLI if you haven't already:
   ```
   npm install -g firebase-tools
   ```

2. Login to Firebase:
   ```
   firebase login
   ```

3. Initialize Firebase in your project (if not already done):
   ```
   firebase init firestore
   ```

4. Deploy the rules:
   ```
   firebase deploy --only firestore:rules
   ```

## Testing the Rules

After deploying the rules, you can test them using the diagnostic screen in the app:

1. Open the app in debug mode
2. **Log in first** - this is critical as Firebase permissions require authentication
3. Navigate to the login screen
4. Tap on "System Diagnostics" at the bottom
5. Tap "Test Firebase" to verify the permissions

If the tests pass, you should see:
- write_test: success
- read_users: success
- read_public: success

## Troubleshooting

If you still encounter permission issues:

1. **Make sure you're authenticated in the app** - The diagnostic screen now checks this and will show an error if not logged in
2. **Wait after publishing rules** - Firebase security rules can take 1-2 minutes to propagate after publishing
3. **Check rule syntax** - Ensure there are no syntax errors in the rules
4. **Verify collection names** - Make sure the collection names in the rules match those in your database
5. **Add yourself as an admin** - You can update a user document to have `role: "admin"` for complete access
6. **Check Firebase project ID** - Ensure your app is connecting to the same Firebase project where you updated the rules
7. **Use test accounts** - Use the "Create Test Accounts" button on the login screen to set up accounts with proper permissions

## Common Firebase Permission Error Messages

If you see these messages in your diagnostics:

- **Missing or insufficient permissions**: This means your rules don't allow the specific operation.
- **Permission denied**: Your rules explicitly disallow the operation or a required document doesn't exist.
- **Resource not found**: You're trying to operate on a document that doesn't exist.

Remember that changes to Firebase security rules may take a few minutes to propagate. 
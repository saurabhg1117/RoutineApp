# Codemagic CI/CD Setup Guide

This guide will help you set up continuous integration and deployment for your Gold App using Codemagic.

## Prerequisites

1. A Codemagic account (sign up at https://codemagic.io)
2. Your Flutter project pushed to a Git repository (GitHub, GitLab, or Bitbucket)
3. (Optional) Google Play Console account for publishing

## Step 1: Connect Your Repository

1. Log in to Codemagic
2. Click "Add application"
3. Select your Git provider (GitHub, GitLab, or Bitbucket)
4. Choose your repository
5. Select "Flutter" as the project type

## Step 2: Configure Environment Variables

### For Android Signing (Required for Release Builds)

1. In Codemagic, go to your app settings
2. Navigate to "Environment variables"
3. Create a group called `keystore_credentials` with the following variables:

   - `CM_KEYSTORE_PATH`: Path to your keystore file (e.g., `android/app/keystore.jks`)
   - `CM_KEYSTORE_PASSWORD`: Your keystore password
   - `CM_KEY_ALIAS`: Your key alias
   - `CM_KEY_PASSWORD`: Your key password

### For Google Play Publishing (Optional)

1. Create a service account in Google Cloud Console
2. Download the JSON key file
3. In Codemagic, add an environment variable:
   - `GCLOUD_SERVICE_ACCOUNT_CREDENTIALS`: Paste the entire contents of your JSON key file

## Step 3: Generate Android Keystore (If You Don't Have One)

If you don't have a keystore file yet, generate one:

```bash
keytool -genkey -v -keystore android/app/keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

**Important**: 
- Store your keystore file securely
- Never commit it to your repository
- Upload it to Codemagic as a secure file

## Step 4: Upload Keystore to Codemagic

1. In Codemagic, go to your app settings
2. Navigate to "Secure files"
3. Upload your `keystore.jks` file
4. Note the path where it will be stored

## Step 5: Update Configuration

The `codemagic.yaml` file is already configured with:

- ✅ Flutter dependency installation
- ✅ Hive adapter generation
- ✅ Code analysis
- ✅ Testing
- ✅ Android App Bundle (AAB) build
- ✅ Android APK build
- ✅ Artifact collection

### Customize Email Notifications

Update the email recipient in `codemagic.yaml`:

```yaml
email:
  recipients:
    - your-email@example.com  # Change this
```

## Step 6: Configure Android Build Settings

The configuration uses:
- **Package Name**: `com.goldapp.daily_routine`
- **App Name**: `Gold App`
- **Flutter Version**: Stable

You can modify these in the `codemagic.yaml` file under `environment.vars`.

## Step 7: Build Configuration

### Android App Bundle (AAB) - For Google Play

The `android-workflow` builds an AAB file suitable for Google Play Store submission.

### Android APK - For Direct Distribution

The `android-apk-workflow` builds an APK file for direct installation.

## Step 8: Google Play Publishing (Optional)

To enable automatic publishing to Google Play:

1. Uncomment the Google Play publishing section in `codemagic.yaml`
2. Set `submit_as_draft: false` when ready for production
3. Ensure `GCLOUD_SERVICE_ACCOUNT_CREDENTIALS` is configured
4. Set the appropriate track (alpha, beta, or production)

## Step 9: Start Your First Build

1. In Codemagic, go to your app
2. Click "Start new build"
3. Select the workflow you want to run:
   - `android-workflow` for AAB (Google Play)
   - `android-apk-workflow` for APK (direct distribution)
4. Select the branch to build
5. Click "Start build"

## Build Artifacts

After a successful build, you can download:

- **AAB file**: `build/app/outputs/bundle/release/app-release.aab`
- **APK file**: `build/app/outputs/flutter-apk/app-release.apk`
- **Mapping file**: For ProGuard/R8 (if enabled)

## Troubleshooting

### Build Fails on Hive Generation

If the build fails during Hive adapter generation:

1. Ensure all model files have proper `@HiveType` annotations
2. Check that `build_runner` is in `dev_dependencies`
3. Verify the `build.yaml` file exists

### Signing Issues

If you encounter signing errors:

1. Verify all keystore credentials are correct
2. Ensure the keystore file is uploaded to Codemagic
3. Check that the keystore path in environment variables matches the uploaded file

### Google Play Upload Fails

1. Verify your service account has the correct permissions
2. Check that the package name matches your Google Play Console app
3. Ensure the app is created in Google Play Console before uploading

## Additional Resources

- [Codemagic Documentation](https://docs.codemagic.io/)
- [Flutter CI/CD Guide](https://docs.codemagic.io/getting-started/building-a-flutter-app/)
- [Android Code Signing](https://docs.codemagic.io/code-signing/android-code-signing/)

## Support

If you encounter issues:
1. Check the build logs in Codemagic
2. Review the error messages
3. Consult Codemagic documentation
4. Contact Codemagic support if needed


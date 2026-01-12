# Codemagic Quick Start Guide

## 🚀 Quick Setup (5 minutes)

### 1. Push Your Code to Git
```bash
git add .
git commit -m "Initial commit with Codemagic config"
git push origin main
```

### 2. Connect to Codemagic

1. Go to [codemagic.io](https://codemagic.io) and sign up/login
2. Click **"Add application"**
3. Select your Git provider (GitHub/GitLab/Bitbucket)
4. Choose your repository
5. Select **"Flutter"** as project type
6. Codemagic will detect the `codemagic.yaml` file automatically

### 3. Configure Environment Variables (Optional for Testing)

For **testing builds**, you can skip this step. The app will build with debug signing.

For **release builds** (Google Play), you need:

#### Create Keystore (One-time setup)
```bash
keytool -genkey -v -keystore android/app/keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias key \
  -storepass YOUR_STORE_PASSWORD \
  -keypass YOUR_KEY_PASSWORD
```

#### Add to Codemagic

1. In Codemagic app settings → **Environment variables**
2. Create group: `keystore_credentials`
3. Add variables:
   - `CM_KEYSTORE_PATH`: Upload your `keystore.jks` file in **Secure files** section, then use the path
   - `CM_KEYSTORE_PASSWORD`: Your store password
   - `CM_KEY_ALIAS`: `key` (or your alias)
   - `CM_KEY_PASSWORD`: Your key password

### 4. Start Your First Build

1. Click **"Start new build"**
2. Select workflow:
   - `android-apk-workflow` for APK (faster, for testing)
   - `android-workflow` for AAB (Google Play)
3. Select branch (usually `main` or `master`)
4. Click **"Start build"**

### 5. Download Your App

After build completes (5-10 minutes):
- Go to **Builds** tab
- Click on your build
- Download the APK/AAB from **Artifacts** section

## 📱 What Gets Built

- **APK**: `build/app/outputs/flutter-apk/app-release.apk`
- **AAB**: `build/app/outputs/bundle/release/app-release.aab` (for Google Play)

## 🔧 Configuration Files

- `codemagic.yaml` - Main CI/CD configuration
- `.codemagic.yaml` - Alternative config file
- Both files are identical, Codemagic will use whichever it finds

## ⚙️ Customization

### Change Email Notifications

Edit `codemagic.yaml`:
```yaml
email:
  recipients:
    - your-email@example.com  # Change this
```

### Enable Google Play Publishing

1. Get Google Play service account JSON
2. Add to Codemagic environment variables as `GCLOUD_SERVICE_ACCOUNT_CREDENTIALS`
3. Uncomment Google Play section in `codemagic.yaml`

## 🐛 Troubleshooting

### Build Fails
- Check build logs in Codemagic
- Ensure all dependencies are in `pubspec.yaml`
- Verify Flutter version compatibility

### Signing Issues
- Verify keystore credentials are correct
- Check keystore file is uploaded to Secure files
- Ensure environment variable names match exactly

### Hive Generation Fails
- This is normal if models aren't fully set up
- The build continues with `|| true` in scripts
- Fix model annotations and rebuild

## 📚 Next Steps

1. **Test the APK** on your device
2. **Set up Google Play** if publishing to store
3. **Configure automatic builds** on git push
4. **Add more workflows** for different build types

## 💡 Pro Tips

- Start with APK workflow for faster testing
- Use AAB workflow only when ready for Google Play
- Enable email notifications to track builds
- Set up branch-specific workflows if needed

---

**Need Help?** Check [CODEMAGIC_SETUP.md](CODEMAGIC_SETUP.md) for detailed instructions.



![image](https://github.com/user-attachments/assets/3088b974-8672-4954-a4e2-51721b916f31)



# Atomic Notes Project

All you need is a simple yet effective note application. Atomic Notes is a robust and user-friendly note-taking application designed to prioritize security and convenience. With powerful encryption, cloud sync capabilities, and intuitive features, Atomic Notes ensures that your notes are protected and easily accessible wherever you go.

## You Can now fork the repo

#No Tracking
#No Data Thefting
#No Permission Required
#Your Data, Your control

- Atomic Notes come with offline and online cloud storage synchronization.
- Will provide encryption over personal data and real-time cloud sync.
- Will give the user total control over their personal data.
- Come with offline local storage, so you can access your notes at any time without an internet connection.
- For the safety of notes, cloud backup is available in the application with a fast cloud sync function. 
- The application is packed with a beautiful UI and user-friendly design.
- Optimized and power-full.
__________________________________________________________________
- 📫 You can reach me from email: DevBehindYou@gmail.com
- Ongoing Project.
- source code will available soon.

# Features:

Security:
  
- AES 256-bit Encryption: All notes are encrypted using AES 256-bit encryption, providing maximum security for your sensitive information.

- Biometric Authentication: Secure your notes with biometric authentication (fingerprint or face recognition) for effortless yet robust protection.

- User-Controlled Cloud Backup: Manage and delete your cloud backups directly from the app, ensuring complete control over your data's privacy.

# Future Roadmap:

- Expansion: We plan to launch SecureNote on the Google Play Store, expanding our reach to a wider audience.

- Platform Independence: In the future, we aim to develop SecureNote for various platforms, including web, iOS, Android, and Windows, to cater to diverse user preferences.

# Known Issues:

- Sync Errors: Sync errors may occur due to unstable internet connections.
Manual sync option available to mitigate automatic sync failures.

- Biometric Authentication: Biometric authentication enhances security but may encounter issues on unsupported devices or versions.
Removing device lock can lead to app instability or crashes, especially on older Android versions.

- Multiple Password Attempts: Non-biometric devices, particularly pre-Android 9 versions, may be vulnerable to multiple password attempts.
Consider implementing additional security measures or limiting login attempts to mitigate risks.

# Troubleshooting:
- App Stability: App crashes are minimized, but if encountered, ensure the latest version is installed.
If crashes persist, provide device details and steps to reproduce for support.

- Sync Errors: Unstable internet connections may lead to sync errors. Verify network stability.
Manually trigger sync if automatic sync fails to resolve temporary network issues.

- Biometric Authentication: Biometric authentication enhances security. Ensure device and app support.
If authentication issues arise, re-enroll biometric data and verify app permissions.

- Device Lock Removal: Removing device lock can cause app instability or crashes. Recommend keeping it enabled.
If instability occurs after lock removal, consider re-enabling it or contacting support.

- Multiple Password Attempts: Implement security measures to prevent brute-force attacks on non-biometric devices.
Educate users on password strength and recommend enabling device lock for added security.

# System Requirements:

Operating System: Android, ios comming soon 
Minimum SDK Level: 23 (Android 6.0, Marshmallow)
Recommended SDK Level: 32 (Android 12, S)
Hardware: arm64v8 or armv7, Compatible with devices running Android 6.0 or later

# Dependencies:

flutter_lints dbms google_nav_bar hive hive_flutter lutter_slidable flutter_svg provider flutter_staggered_grid_view connectivity_plus smooth_page_indicator cupertino_icons local_auth encrypt

# AES encryption

- key[32bit] + vi[16bit]
- base64 + base32
  
Example:

Uint8List encryptMessage(Uint8List key, Uint8List iv, String message) {

  final plaintext = Uint8List.fromList(utf8.encode(message));
  
  final paddedPlaintext = padPlaintext(plaintext);

  final cipher = CBCBlockCipher(AESFastEngine())
    ..init(
      true,
      ParametersWithIV(KeyParameter(key), iv),
    );

  return cipher.process(Uint8List.fromList(paddedPlaintext));
}

Uint8List padPlaintext(Uint8List plaintext) {

  final blockSize = 16;
  
  final paddedLength = blockSize * ((plaintext.length + blockSize - 1) ~/ blockSize);
  
  final paddingLength = paddedLength - plaintext.length;
  
  final paddedPlaintext = Uint8List(paddedLength)..setAll(0, plaintext);
  
  paddedPlaintext.fillRange(plaintext.length, paddedLength, paddingLength);
  
  return paddedPlaintext;
}

void main() {

  final key = Uint8List.fromList(utf8.encode('your_secret_key_here'));
  
  final iv = Uint8List(16); // Initialization Vector
  
  final message = 'your_note_here';

  final encryptedMessage = encryptMessage(key, iv, message);
  
  print('Encrypted message: ${base64.encode(encryptedMessage)}');
}
# Intro Images:
> ![image](https://github.com/user-attachments/assets/9405e2b9-771b-4899-8e4d-110e73e81f82) ![image](https://github.com/user-attachments/assets/30515773-2c4e-4f3f-bc60-9fcd9b406d24) ![image](https://github.com/user-attachments/assets/130cddd6-affe-4419-bf47-98c605b0b4a7) ![image](https://github.com/user-attachments/assets/b4be4dcf-90df-4b2a-9e2f-22a03418f309) ![image](https://github.com/user-attachments/assets/6332f8e0-289b-47c6-9db7-ea33157589fc) ![image](https://github.com/user-attachments/assets/be0db0f0-d767-4103-aff4-f725e3d39c57)












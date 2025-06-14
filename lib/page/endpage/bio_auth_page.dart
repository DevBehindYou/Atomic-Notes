// ignore_for_file: use_build_context_synchronously

import 'package:atomic_notes/utility/component/my_appbar.dart';
import 'package:atomic_notes/utility/component/my_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';

class BiomPage extends StatefulWidget {
  const BiomPage({super.key});

  @override
  State<BiomPage> createState() => _BiomPageState();
}

class _BiomPageState extends State<BiomPage> {
  late final Box<bool>? _authBox; // Updated to Box<bool>
  late final LocalAuthentication auth;
  bool isAuthOn = false;
  bool _supportState = false;

  @override
  void initState() {
    auth = LocalAuthentication();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() {
            _supportState = isSupported;
          }),
        );
    _initAuthHive();
    super.initState();
  }

  void _initAuthHive() async {
    await Hive.openBox<bool>('authBox').then((box) {
      _authBox = box;
      setState(() {
        isAuthOn = _authBox!.get('isAuthOn', defaultValue: false) ?? false;
      });
    });
  }

  Future<bool> _checkCapability() async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: "Checking Device Capability",
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: false,
          ));

      if (authenticated) {
        return true;
      }
      return false;
    } on PlatformException catch (_) {
      const MySnackBar(
        text: "Error Establishing Biometric Auth",
        sec: 2000,
      ).showMySnackBar(context);
      return false;
    }
  }

  @override
  void dispose() {
    _authBox!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff29283A),
      appBar: const MyAppBar(text: "Security"),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 250,
                child: RichText(
                  text: TextSpan(
                    text: 'Biometric Authentication',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              "\nUse biometric authentication of the device to access Atomic when available.",
                          style: TextStyle(
                              color: Colors.grey.shade300,
                              fontSize: 10,
                              overflow: TextOverflow.ellipsis)),
                    ],
                  ),
                ),
              ),
              CupertinoSwitch(
                value: isAuthOn,
                activeColor: const Color(0xff9f5ef7),
                onChanged: (bool value) async {
                  if (_supportState && await _checkCapability()) {
                    setState(() {
                      isAuthOn = value;
                      _authBox!.put('isAuthOn', isAuthOn);
                      if (isAuthOn) {
                        const MySnackBar(
                          text: "Biometric Authentication On",
                          sec: 2000,
                        ).showMySnackBar(context);
                      } else {
                        const MySnackBar(
                          text: "Biometric Authentication Off",
                          sec: 2000,
                        ).showMySnackBar(context);
                      }
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Text(
              "The device should have a lock screen password and fingerprint sensor to enable biometric authentication. If the app's biometric authentication is enabled, removing the lock screen password may result in a crash or abnormal activity.",
              style: TextStyle(
                color: Colors.grey.shade200,
                fontSize: 13,
              ),
            ),
          )
        ],
      ),
    );
  }
}

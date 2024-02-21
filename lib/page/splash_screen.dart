// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unnecessary_const

import 'package:atomic_notes/database/database.dart';
import 'package:atomic_notes/utility/component/logo_container_2.dart';
import 'package:atomic_notes/utility/component/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final NotesDataBase db = NotesDataBase();
  final _myBox = Hive.box('myBox');
  final supabase = Supabase.instance.client;
  late final Box<bool>? _authBox;
  late bool isAuthOn;

  @override
  void initState() {
    super.initState();
    _initAuthHive();
    _redirect();
  }

  void _initAuthHive() async {
    await Hive.openBox<bool>('authBox').then((box) {
      _authBox = box;
      setState(() {
        isAuthOn = _authBox!.get('isAuthOn', defaultValue: false) ?? false;
      });
    });
  }

  Future<void> _redirect() async {
    if (!mounted) {
      return;
    }
    try {
      final session = supabase.auth.currentSession;
      if (session != null) {
        if (_myBox.get("NOTESLIST") == null) {
          await db.loadAndSyncSupabaseData();
          await Future.delayed(const Duration(seconds: 2));
          Navigator.pushReplacementNamed(context, '/onboardingscreen');
        } else {
          await db.loadLocalData();
          await Future.delayed(const Duration(seconds: 2), () {
            if (isAuthOn) {
              Navigator.pushReplacementNamed(context, '/lockscreen');
            } else {
              Navigator.pushReplacementNamed(context, '/mainpage');
            }
          });
        }
      } else {
        await Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacementNamed(context, '/loginpage');
        });
      }
    } catch (error) {
      // force to go on login page
      Navigator.pushReplacementNamed(context, '/loginpage');
    }
  }

  @override
  void dispose() {
    _authBox?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff29283A),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoContainer2(),
            const SizedBox(height: 160),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: const Color(0xff855ef7),
                  borderRadius: BorderRadius.circular(16)),
              child: const circularProgress(),
            ),
          ],
        ),
      ),
    );
  }
}

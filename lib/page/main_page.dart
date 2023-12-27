// ignore_for_file: use_build_context_synchronously, use_super_parameters, unrelated_type_equality_checks, deprecated_member_use, curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:atomic_notes/authentication/auth_services/auth_service.dart';
import 'package:atomic_notes/database/database.dart';
import 'package:atomic_notes/database/sync_status.dart';
import 'package:atomic_notes/page/home_page.dart';
import 'package:atomic_notes/page/settings_page.dart';
import 'package:atomic_notes/utility/component/cloud_button.dart';
import 'package:atomic_notes/utility/component/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final supabase = Supabase.instance.client;
  final AuthServices serve = AuthServices();
  final NotesDataBase db = NotesDataBase();
  late StreamSubscription<AuthState> _authStateChangesSubscription;
  late bool isSyncOn;
  final _myBox = Hive.box('myBox');
  String? username = "@ensyncuser";
  bool _isLoading = false;
  int currentIndex = 0;

  final List _pages = [
    // home page
    const HomePage(),

    // settings page
    const SettingsPage(),
  ];

  // Create a function that returns a StreamSubscription of AuthState
  StreamSubscription<AuthState> getAuthStateSubscription() {
    // Listen to the onAuthStateChange stream and return the state
    return Supabase.instance.client.auth.onAuthStateChange.listen((state) {
      // If the user is signed in, update the state with their details
      if (state.event == AuthChangeEvent.signedIn) {
        // If the user is signed out, reset the state
      } else if (state.event == AuthChangeEvent.signedOut) {
        Navigator.pushReplacementNamed(context, '/splashpage');
      }
    });
  }

  @override
  void initState() {
    _authStateChangesSubscription = getAuthStateSubscription();
    _getUserName();
    _checkSyncOption();
    super.initState();
  }

  void _checkSyncOption() {
    isSyncOn =
        SyncStatusHelper.syncBox.get('isSyncOn', defaultValue: true) ?? true;
    setState(() {
      isSyncOn;
    });
  }

  // get the user name
  Future<void> _getUserName() async {
    setState(() {
      _isLoading = true;
    });

    try {
      username = await serve.getUserInfo();
    } catch (e) {
      // error
    } finally {
      Future.delayed(const Duration(microseconds: 1), () {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  void dispose() {
    _authStateChangesSubscription.cancel();
    _isLoading = false;
    super.dispose();
  }

  // sync notes data to cloud
  Future<void> _syncData() async {
    if (isSyncOn) {
      final connectivityResult = await Connectivity().checkConnectivity();
      setState(() {
        _isLoading = true;
        connectivityResult;
      });

      if (connectivityResult == ConnectivityResult.none) {
        const MySnackBar(
          text: "No Internet Connection!",
          sec: 1000,
        ).showMySnackBar(context);
      } else {
        if (_myBox.get("NOTESLIST").toString() == "[]") {
          const MySnackBar(
            text: "Database is empty!",
            sec: 1000,
          ).showMySnackBar(context);
        } else {
          await db.syncDataToSupabase();
          const MySnackBar(
            text: "Notes Synchronized No need to tap again",
            sec: 1000,
          ).showMySnackBar(context);
        }
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      const MySnackBar(sec: 1000, text: "Cloud Synchronization is Off")
          .showMySnackBar(context);
    }
  }

  Future<void> _exit() async {
    const MySnackBar(
      text: "exiting...",
      sec: 900,
    ).showMySnackBar(context);
    await Future.delayed(const Duration(seconds: 1));
    exit(0);
  }

  void goToPage(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        // title of appbar
        title: GestureDetector(
          onTap: () {
            _getUserName();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            width: 200,
            decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  // bottom right shadow is darker
                  BoxShadow(
                    color: Colors.grey.shade900,
                    offset: const Offset(2, 2),
                    blurRadius: 2,
                    spreadRadius: 1,
                  ),
                ]),
            child: Row(
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17.5),
                      border:
                          Border.all(width: 0.7, color: Colors.grey.shade300)),
                  child: const CircleAvatar(
                    backgroundImage: AssetImage('assets/photo.png'),
                  ),
                ),
                const SizedBox(width: 7),
                _isLoading
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 12,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade700,
                                borderRadius: BorderRadius.circular(7)),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            height: 14,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade700,
                                borderRadius: BorderRadius.circular(7)),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Atomic",
                            style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            username!,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.grey.shade100,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )
              ],
            ),
          ),
        ),

        actions: [
          Row(
            children: [
              CloudButton(
                ico: "assets/sync.svg",
                action: _syncData,
                clr: 0xff5F5EF7,
                isLoading: _isLoading,
              ),
              const SizedBox(width: 15),
            ],
          )
        ],

        leading: GestureDetector(
          onTap: () {
            const MySnackBar(
              text: "DoubleTap to exit",
              sec: 900,
            ).showMySnackBar(context);
          },
          onDoubleTap: () {
            _exit();
          },
          child: Center(
            child: Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.all(9.0),
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: const Color(0xff855ef7),
                borderRadius: BorderRadius.circular(11),
              ),
              child: SvgPicture.asset(
                'assets/back_arrow.svg',
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: const Color(0xff323130),
        elevation: 0,
      ),
      // pages to show in body
      body: _pages[currentIndex],

      // bottom Navigation bar section
      bottomNavigationBar: Container(
        color: const Color(0xff232427),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: GNav(
            mainAxisAlignment: MainAxisAlignment.center,
            onTabChange: (index) => goToPage(index),
            backgroundColor: const Color(0xff232427),
            color: Colors.white,
            activeColor: const Color(0xff5F5EF7),
            tabBackgroundColor: const Color(0xff121212),
            gap: 5,
            padding: const EdgeInsets.all(14.0),
            tabs: const [
              GButton(
                icon: Icons.note,
                text: 'Notes',
                textStyle: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w500),
              ),
              GButton(
                icon: Icons.miscellaneous_services_rounded,
                text: 'Misc',
                textStyle: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

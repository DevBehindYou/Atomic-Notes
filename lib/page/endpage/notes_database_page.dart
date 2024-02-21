// ignore_for_file: use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:atomic_notes/database/database.dart';
import 'package:atomic_notes/utility/component/my_snackbar.dart';
import 'package:atomic_notes/utility/component/my_appbar.dart';
import 'package:atomic_notes/utility/component/logout_dialogbox.dart';
import 'package:flutter/material.dart';

class DatabasePage extends StatefulWidget {
  const DatabasePage({super.key});

  @override
  State<DatabasePage> createState() => _DatabasePageState();
}

class _DatabasePageState extends State<DatabasePage> {
  final NotesDataBase db = NotesDataBase();
  int localNotesNum = 0;
  String cloudNotes = '-';
  bool _mounted = true;
  String synctime = '-';

  @override
  void initState() {
    _getDBLocalNum();
    super.initState();
  }

  Future<void> _getData() async {
    if (!_mounted) return;

    final connectivityResult = await Connectivity().checkConnectivity();
    if (!_mounted) return; // Check again before updating state
    setState(() {
      connectivityResult;
    });
    if (connectivityResult == ConnectivityResult.none) {
      const MySnackBar(
        text: "No Internet Connection!",
        sec: 1000,
      ).showMySnackBar(context);
    } else {
      String count = await db.countNotesNumFromCloud();
      String time = await db.checkModifyStatus();
      if (!_mounted) return; // Check again before updating state
      setState(() {
        synctime = time;
      });
      if (count == '1') {
        if (!_mounted) return; // Check again before updating state
        setState(() {
          cloudNotes = 'Yes';
        });
      } else {
        if (!_mounted) return; // Check again before updating state
        setState(() {
          cloudNotes = 'No';
        });
      }
    }
  }

  void _getDBLocalNum() {
    db.loadLocalData();
    if (_mounted) {
      setState(() {
        localNotesNum = db.notesList.length;
      });
    }
  }

  _showPopUp({required String txt, required Function func}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return DialogBoxLogout(
          action: func,
          text: txt,
        );
      },
    );
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff29283A),
      appBar: const MyAppBar(text: "Database"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color(0xff323130),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 0.5, color: Colors.white)),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Notes in Local Database",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          decoration: BoxDecoration(
                              color: const Color(0xff855ef7),
                              borderRadius: BorderRadius.circular(23)),
                          child: Center(
                            child: Text(
                              localNotesNum.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      indent: 45,
                      endIndent: 45,
                      color: Colors.grey.shade700,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          "Notes Aval. in Cloud DB",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          decoration: BoxDecoration(
                              color: const Color(0xff855ef7),
                              borderRadius: BorderRadius.circular(23)),
                          child: Center(
                            child: Text(
                              cloudNotes,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      indent: 45,
                      endIndent: 45,
                      color: Colors.grey.shade700,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Last Time Backup",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                              color: const Color(0xff855ef7),
                              borderRadius: BorderRadius.circular(23)),
                          child: Center(
                            child: Text(
                              synctime,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _showPopUp(
                txt: "Count how many notes are stored in the cloud database.",
                func: _getData,
              ),
              child: Container(
                margin: const EdgeInsets.all(9.0),
                height: 45,
                decoration: BoxDecoration(
                    color: const Color(0xff5F5EF7),
                    borderRadius: BorderRadius.circular(18)),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Reload Data",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.refresh,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                "This will provide you details about the notes that are stored in both your app's local storage and the cloud database. Tap on the reload button to refresh the data.",
                style: TextStyle(
                  color: Colors.grey.shade200,
                  fontSize: 13,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

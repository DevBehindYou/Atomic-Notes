// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:atomic_notes/database/database.dart';
import 'package:atomic_notes/utility/component/danger_tiles.dart';
import 'package:atomic_notes/utility/component/my_snackbar.dart';

import 'package:atomic_notes/utility/component/my_appbar.dart';
import 'package:flutter/material.dart';

class DevPage extends StatelessWidget {
  const DevPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NotesDataBase db = NotesDataBase();
    bool mounted = true;

    // dev options function
    Future<void> forceFetchNotes() async {
      await db.forceLoadAndSyncSupabaseData();
      if (mounted) {
        const MySnackBar(
          text: "Cloud data fetched successfully",
          sec: 2000,
        ).showMySnackBar(context);
      }
    }

    // dev options function
    Future<void> deleteLocalData() async {
      await db.destroyLocalDataStorage();
      if (mounted) {
        const MySnackBar(
          text: "Local data deleted successfully",
          sec: 2000,
        ).showMySnackBar(context);
      }
    }

    // dev options function
    Future<void> deleteCloudData() async {
      String response = await db.deleteSupabaseData();
      if (mounted) {
        MySnackBar(
          text: response,
          sec: 2000,
        ).showMySnackBar(context);
      }
    }

    return Scaffold(
      appBar: const MyAppBar(text: "Developer Options"),
      backgroundColor: const Color(0xff29283A),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(7.0),
              margin: const EdgeInsets.all(11.0),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(width: 1.0, color: const Color(0xffff2b00))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // fetch data
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: DangerTile(
                      func: forceFetchNotes,
                      text: "FORCE TO FETCH CLOUD DATA",
                      txt:
                          "Are you sure you want to fetch notes from the cloud?\nWarning: By doing so, it will double or create duplicates of your notes.",
                    ),
                  ),
                  // delete data
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: DangerTile(
                      func: deleteCloudData,
                      text: "FORCE TO DELETE CLOUD DATA",
                      txt:
                          "Are you sure you want to delete your notes stored in the cloud?\nWarning: By doing so, it will empty your notes data in the cloud",
                    ),
                  ),

                  // destroy local data
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: DangerTile(
                      func: deleteLocalData,
                      text: "FORCE TO DESTROY LOCAL DATA",
                      txt:
                          "Are you sure you want to delete notes from local storage?\nWarning: By doing so, it will delete all notes stored in the local data storage.",
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

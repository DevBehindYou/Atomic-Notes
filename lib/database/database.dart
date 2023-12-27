// ignore_for_file: deprecated_member_use

import 'package:atomic_notes/database/sync_status.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotesDataBase {
  final supabase = Supabase.instance.client;
  late String userId = supabase.auth.currentUser!.id;
  List<dynamic> notesList = [];

  final _myBox = Hive.box('myBox');
  late final Box<bool>? _authBox;

  // Load the data from the local Hive database
  Future<void> loadLocalData() async {
    notesList = _myBox.get("NOTESLIST");
  }

  // Update the local Hive database
  Future<void> updateLocalData() async {
    _myBox.put("NOTESLIST", notesList);
  }

  // Function to clear Hive data and notesList
  Future<void> clearDataOnLogout() async {
    // Clear data in Hive
    _myBox.delete("NOTESLIST");
    await Hive.openBox<bool>('authBox').then((box) {
      _authBox = box;
      _authBox!.put('isAuthOn', false);
    });
    await SyncStatusHelper.setSyncStatus(true);

    // Clear notesList
    notesList.clear();
  }

  // Destroy local data storage
  Future<void> destroyLocalDataStorage() async {
    notesList.clear();
    notesList.add(['Ensync', 'You destroyed your notes data XD', 'created_at']);
    await updateLocalData();
  }

  // Sync data from local Hive to Supabase
  Future<void> syncDataToSupabase() async {
    try {
      loadLocalData();
      final notesTable = supabase.from('ensyncnotes');
      await notesTable.delete().eq('user_id', userId);

      // Insert each note into Supabase
      for (final note in notesList) {
        await notesTable.insert({
          'tittle': note[0],
          'note': note[1],
          'created_at': note[2],
        });
      }
    } catch (error) {
      // return snackbar
    }
  }

  // Load data from Supabase and update the local Hive database
  Future<void> loadAndSyncSupabaseData() async {
    try {
      final notesTable = supabase.from('ensyncnotes');

      // Fetch data from Supabase based on the user ID
      final response = await notesTable
          .select('tittle, note, created_at')
          .eq('user_id', userId)
          .select();

      // Extract notes from the response
      final List<dynamic> supabaseNotes = response;

      if (supabaseNotes == []) {
        loadLocalData();
      } else {
        // Update local Hive database with notes from Supabase
        notesList.clear(); // Clear existing local data
        for (final note in supabaseNotes) {
          notesList.add([note['tittle'], note['note'], note['created_at']]);
        }
      }

      updateLocalData();
    } catch (error) {
      // return snackbar
    }
  }

  // count ht e number ot note user have in the database
  Future<String> countNotesNumFromCloud() async {
    final notesTable = supabase.from('ensyncnotes');
    try {
      final res = await notesTable
          .select('id')
          .eq('user_id', userId)
          .count(CountOption.exact);
      final count = res.count;
      return count.toString();
    } catch (e) {
      return "-";
    }
  }

  // Load data from Supabase and update the local Hive database
  Future<void> forceLoadAndSyncSupabaseData() async {
    try {
      loadLocalData();
      final notesTable = supabase.from('ensyncnotes');

      // Fetch data from Supabase based on the user ID
      final response = await notesTable
          .select('tittle, note, created_at')
          .eq('user_id', userId)
          .select();

      // Extract notes from the response
      final List<dynamic> supabaseNotes = response;

      if (supabaseNotes == []) {
        loadLocalData();
      } else {
        // Update local Hive database with notes from Supabase
        int index = notesList.length - 1;
        for (final note in supabaseNotes) {
          index++;
          notesList.insert(
              index, [note['tittle'], note['note'], note['created_at']]);
        }
      }

      updateLocalData();
    } catch (error) {
      // return snackbar
    }
  }

  Future<void> deleteSupabaseData() async {
    try {
      final notesTable = supabase.from('ensyncnotes');
      await notesTable.delete().eq('user_id', userId);
    } catch (e) {
      //return error
    }
  }
}

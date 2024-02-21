import 'dart:convert';
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
    try {
      notesList = _myBox.get("NOTESLIST");
    } catch (e) {
      notesList.isEmpty;
    }
  }

  // Update the local Hive database
  Future<void> updateLocalData() async {
    _myBox.put("NOTESLIST", notesList);
  }

  // Function to clear Hive data and notesList
  Future<void> clearDataOnLogout() async {
    // Clear data in Hive
    _myBox.delete("NOTESLIST");
    notesList.clear();
    // set everything default
    await Hive.openBox<bool>('authBox').then((box) {
      _authBox = box;
      _authBox!.put('isAuthOn', false);
    });
    await SyncStatusHelper.setSyncStatus(true);
  }

  // Destroy local data storage
  Future<void> destroyLocalDataStorage() async {
    notesList.isEmpty;
    await updateLocalData();
  }

  // Sync data from local Hive to Supabase
  Future<void> syncDataToSupabase() async {
    try {
      loadLocalData();
      final notesTable = supabase.from('atomicnote');
      await notesTable.delete().eq('user_id', userId);

      // Serialize notesList to JSON string
      String notesJson = jsonEncode(notesList);

      // Insert the JSON string into the 'note' column
      await notesTable.insert({
        'note': notesJson,
        'modify': DateTime.now().toString().substring(0, 16),
      });
    } catch (error) {
      // Handle error
    }
  }

  // Load data from Supabase and update the local Hive database
  Future<void> loadAndSyncSupabaseData() async {
    try {
      final notesTable = supabase.from('atomicnote');

      // Fetch data from Supabase based on the user ID
      final response = await notesTable.select('note').eq('user_id', userId);

      // Extract notes from the response
      final List<dynamic> supabaseNotes = response;

      if (supabaseNotes.isEmpty) {
        // If no data is retrieved from Supabase, load local data
        await loadLocalData();
      } else {
        // Decode base91 string back to UTF-8 bytes
        String base64Encoded = supabaseNotes[0]['note'];
        List<int> utf8Bytes = base64.decode(base64Encoded);

        // Decode UTF-8 bytes to JSON string
        String notesJson = utf8.decode(utf8Bytes);

        // Update local data with notes from Supabase
        notesList = jsonDecode(notesJson);

        // Update local data
        await updateLocalData();
      }
    } catch (error) {
      // Handle error
    }
  }

  // count the number of notes user have in the database
  Future<String> countNotesNumFromCloud() async {
    final notesTable = supabase.from('atomicnote');
    try {
      final res = await notesTable
          .select('id')
          .eq('user_id', userId)
          .count(CountOption.exact);
      final count = res.count;
      return count.toString();
    } catch (e) {
      return "0";
    }
  }

  Future<String> checkModifyStatus() async {
    final notesTable = supabase.from('atomicnote');
    try {
      final data =
          await notesTable.select('modify').eq('user_id', userId).single();
      if (data.isNotEmpty) {
        if (data['modify'] == '') {
          return "No data found";
        }
        String time = "${data['modify']}";
        return time.substring(0, 16);
      } else {
        return "No data found";
      }
    } catch (error) {
      return "No data found";
    }
  }

  Future<void> forceLoadAndSyncSupabaseData() async {
    try {
      loadLocalData();
      final notesTable = supabase.from('atomicnote');
      final response = await notesTable.select('note').eq('user_id', userId);

      // Extract notes from the response
      final List<dynamic> supabaseNotes = response;

      if (supabaseNotes.isNotEmpty) {
        // Decode base64 string back to UTF-8 bytes
        String base64Encoded = supabaseNotes[0]['note'];
        List<int> utf8Bytes = base64.decode(base64Encoded);

        // Decode UTF-8 bytes to JSON string
        String notesJson = utf8.decode(utf8Bytes);

        // Parse JSON string to List<dynamic>
        List<dynamic> supabaseData = jsonDecode(notesJson);

        // Merge fetched data with existing notesList
        for (var item in supabaseData) {
          if (!notesList.contains(item)) {
            notesList.add(item);
          }
        }

        // Update local data
        await updateLocalData();
      }
    } catch (error) {
      // Handle error
    }
  }

  Future<String> deleteSupabaseData() async {
    try {
      final notesTable = supabase.from('atomicnote');
      await notesTable.delete().eq('user_id', userId);
      return "Cloud data deleted successfully";
    } catch (e) {
      //return error
      return "Failed to delete data";
    }
  }
}

// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:atomic_notes/page/notes_editor_page.dart';
import 'package:atomic_notes/utility/component/my_floating_button.dart';
import 'package:atomic_notes/utility/component/my_snackbar.dart';
import 'package:atomic_notes/utility/component/note_skeliton.dart';
import 'package:flutter/material.dart';
import 'package:atomic_notes/database/database.dart';
import 'package:atomic_notes/utility/component/notes_builder.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotesDataBase db = NotesDataBase();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  late String createdAt;
  final ScrollController _controller = ScrollController();
  bool _isLoading = false;
  bool _mounted = true;

  @override
  initState() {
    _loadNotes();
    super.initState();
  }

  @override
  void dispose() {
    _notesController.dispose();
    _titleController.dispose();
    _mounted = false;
    _isLoading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff29283A),
      body: Scrollbar(
        radius: const Radius.circular(5.0),
        thickness: 5.0,
        controller: _controller,
        child: _isLoading
            ? const Skeliton()
            : db.notesList.isEmpty
                ? Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: const Color(0xff323130),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Text(
                        "No notes are available",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  )
                : MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    controller: _controller,
                    itemCount: db.notesList.length,
                    itemBuilder: (context, index) {
                      return NotesBulder(
                        tittle: db.notesList[index][0].toString(),
                        note: db.notesList[index][1].toString(),
                        when: db.notesList[index][2].toString(),
                        editFunction: () => _editFunction(context, index),
                        deleteFunction: (context) =>
                            _deleteFunction(context, index),
                      );
                    },
                  ),
      ),
      floatingActionButton: MyFloatingButton(
        ico: "assets/add.svg",
        action: _goToCreateNote,
        colorValue: 0xff855ef7,
      ),
    );
  }

  // functions used in homepage

  void _loadNotes() {
    if (!_mounted) return;

    setState(() {
      _isLoading = true;
    });
    db.loadLocalData();
    setState(() {
      _isLoading = false;
    });
  }

  void _saveNewNote() {
    if (_notesController.text.trimLeft() == "" &&
        _titleController.text.trimLeft() == "") {
      const MySnackBar(
        text: "Empty Note Discarded",
        sec: 200,
      ).showMySnackBar(context);
      _titleController.clear();
      _notesController.clear();
    } else {
      setState(() {
        db.notesList.add([
          _titleController.text,
          _notesController.text,
          DateTime.now().toString().substring(0, 16)
        ]);
        _titleController.clear();
        _notesController.clear();
      });
      db.updateLocalData();
    }
  }

  void _goToCreateNote() {
    _titleController.clear();
    _notesController.clear();
    createdAt = "Processing...";
    _showNotesCreaterPage(onSave: _saveNewNote);
  }

  void _deleteFunction(BuildContext context, int index) {
    setState(() {
      db.notesList.removeAt(index);
    });
    const MySnackBar(
      text: "Note Deleted",
      sec: 200,
    ).showMySnackBar(context);
    db.updateLocalData();
  }

  void _editFunction(BuildContext context, int index) {
    _titleController.text = db.notesList[index][0].toString();
    _notesController.text = db.notesList[index][1].toString();
    createdAt = db.notesList[index][2].toString();
    _showNotesCreaterPage(onSave: () => _editNote(context, index));
  }

  void _editNote(BuildContext context, int index) {
    setState(() {
      db.notesList[index][0] = _titleController.text;
      db.notesList[index][1] = _notesController.text;
    });
    db.updateLocalData();
  }

  void _copy() {
    Clipboard.setData(ClipboardData(text: _notesController.text));
    const MySnackBar(
      text: "Note Copied to Clipboard",
      sec: 500,
    ).showMySnackBar(context);
  }

  void _showNotesCreaterPage({required VoidCallback onSave}) {
    showDialog(
      context: context,
      builder: (context) {
        return NotesCreaterPage(
          tittleContoller: _titleController,
          notesController: _notesController,
          createdAt: createdAt,
          onCopy: () => _copy(),
          onSave: () {
            onSave();
            Navigator.of(context).pop();
          },
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/services/note_services.dart';

class NotesByCategory extends StatefulWidget {
  final String category;
  const NotesByCategory({super.key, required this.category});

  @override
  State<NotesByCategory> createState() => _NotesByCategoryState();
}

class _NotesByCategoryState extends State<NotesByCategory> {
  final NoteServices noteServices = NoteServices();
  List<Note> noteList = [];

  @override
  void initState() {
    super.initState();
    _loadNotesByCategory();
  }

  Future<void> _loadNotesByCategory() async {
    noteList = await noteServices.getNotesByCategoryName(widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(widget.category)));
  }
}

import 'package:flutter/material.dart';
import 'package:note_sphere/helpers/snackbar.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/services/note_services.dart';
import 'package:note_sphere/utills/constents.dart';
import 'package:note_sphere/utills/router.dart';
import 'package:note_sphere/utills/text_styles.dart';
import 'package:note_sphere/widgets/note_category_card.dart';

class NotesByCategory extends StatefulWidget {
  final String category;
  const NotesByCategory({super.key, required this.category});

  @override
  State<NotesByCategory> createState() => _NotesByCategoryState();
}

class _NotesByCategoryState extends State<NotesByCategory> {
  List<Note> noteList = [];

  @override
  void initState() {
    _loadNotesByCategory();
    super.initState();
  }

  Future<void> _loadNotesByCategory() async {
    final NoteServices noteServices = NoteServices();
    noteList = await noteServices.getNotesByCategoryName(widget.category);
    setState(() {});
  }

  void _editNote(Note note) {
    AppRouter.router.push('/edit-note', extra: note);
  }

  Future<void> _removeNote(String id) async {
    final NoteServices noteServices = NoteServices();
    try {
      await noteServices.deleteNote(id);
      if (context.mounted) {
        AppHelpers.showSnackBar(context, "Note Deleted Succesfully!");
      }
    } catch (e) {
      if (context.mounted) {
        AppHelpers.showSnackBar(context, "Note Deleted Succesfully!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            AppRouter.router.push("/notes");
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstents.kDefaultPadding,
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(widget.category, style: AppTextStyles.appTitle),
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppConstents.kDefaultPadding,
                  mainAxisSpacing: AppConstents.kDefaultPadding,
                  childAspectRatio: 7 / 11,
                ),
                itemCount: noteList.length,
                itemBuilder: (context, index) {
                  return NoteCategoryCard(
                    noteTitle: noteList[index].title,
                    noteContent: noteList[index].content,
                    removeNote: () async {
                      await _removeNote(noteList[index].id);
                      setState(() {
                        noteList.removeAt(index);
                      });
                    },
                    editNote: () async {
                      _editNote(noteList[index]);
                    },
                    viewSingleNote: () {
                      AppRouter.router.push(
                        "/single-note",
                        extra: noteList[index],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

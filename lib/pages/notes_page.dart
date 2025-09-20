import 'package:flutter/material.dart';
import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/services/note_services.dart';
import 'package:note_sphere/utills/colors.dart';
import 'package:note_sphere/utills/constents.dart';
import 'package:note_sphere/utills/router.dart';
import 'package:note_sphere/utills/text_styles.dart';
import 'package:note_sphere/widgets/notes_card.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final NoteServices noteServices = NoteServices();
  List<Note> allNotes = [];
  Map<String, List<Note>> noteWithCategory = {};

  @override
  void initState() {
    _checkIfUserIsNewAndCreateInitialNotes();
    super.initState();
  }

  void _checkIfUserIsNewAndCreateInitialNotes() async {
    final bool isNewUser = await noteServices.isNewUser();
    if (isNewUser) {
      await noteServices.createInitialNotes();
    }
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final List<Note> loadNotes = await noteServices.loadNotes();
    final Map<String, List<Note>> noteByCategory = noteServices
        .getNotesByCategoryMap(loadNotes);
    setState(() {
      allNotes = loadNotes;
      noteWithCategory = noteByCategory;
      print(noteWithCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            AppRouter.router.go("/");
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(color: AppColors.kWhiteColor),
        ),
        child: Icon(Icons.add, color: AppColors.kWhiteColor, size: 30),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(AppConstents.kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notes", style: AppTextStyles.appTitle),
            SizedBox(height: 20),
            allNotes.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(
                      child: Text(
                        "No notes available , click on the + button to add a new note",
                        style: AppTextStyles.appDescription,
                      ),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: noteWithCategory.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppConstents.kDefaultPadding,
                      mainAxisSpacing: AppConstents.kDefaultPadding,
                      childAspectRatio: 6 / 4,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          AppRouter.router.push(
                            "/category",
                            extra: noteWithCategory.keys.elementAt(index),
                          );
                        },
                        child: NotesCard(
                          noteCategory: noteWithCategory.keys.elementAt(index),
                          numOfNotes: noteWithCategory.values
                              .elementAt(index)
                              .length,
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

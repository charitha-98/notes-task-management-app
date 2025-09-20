// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_sphere/helpers/snackbar.dart';

import 'package:note_sphere/models/note_model.dart';
import 'package:note_sphere/services/note_services.dart';
import 'package:note_sphere/utills/colors.dart';
import 'package:note_sphere/utills/constents.dart';
import 'package:note_sphere/utills/router.dart';

import 'package:note_sphere/utills/text_styles.dart';

class UpdateNotePage extends StatefulWidget {
  final Note note;
  const UpdateNotePage({super.key, required this.note});

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  List<String> categories = [];
  final NoteServices noteServices = NoteServices();

  final _formKeys = GlobalKey<FormState>();
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();

  String category = "";

  Future _loadCategories() async {
    categories = await noteServices.getAllCategories();
    setState(() {});
  }

  @override
  void dispose() {
    _noteTitleController.dispose();
    _noteContentController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _noteTitleController.text = widget.note.title;
    _noteContentController.text = widget.note.content;
    category = widget.note.category;
    _loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note", style: AppTextStyles.appSubtitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppConstents.kDefaultPadding / 2,
              ),
              child: Form(
                key: _formKeys,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a category";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(
                          color: AppColors.kWhiteColor,
                          fontFamily: GoogleFonts.dmSans().fontFamily,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                        isExpanded: false,
                        hint: Text("Category"),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: AppColors.kWhiteColor.withOpacity(0.1),
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppConstents.kDefaultPadding,
                            ),
                            borderSide: BorderSide(
                              color: AppColors.kWhiteColor,
                              width: 1,
                            ),
                          ),
                        ),
                        items: categories.map((String category) {
                          return DropdownMenuItem<String>(
                            alignment: Alignment.centerLeft,
                            value: category,
                            child: Text(
                              category,
                              style: AppTextStyles.appButton,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            category = value!;
                          });
                        },
                      ),
                    ),
                    TextFormField(
                      controller: _noteTitleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a title";
                        }
                        return null;
                      },
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 30,
                      ),
                      decoration: InputDecoration(
                        hintText: "Note Title",
                        hintStyle: TextStyle(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                          fontSize: 35,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _noteContentController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your content";
                        }
                        return null;
                      },
                      maxLines: 12,
                      style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        hintText: "Note Content",
                        hintStyle: TextStyle(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                          fontSize: 20,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(
                      color: AppColors.kWhiteColor.withOpacity(0.2),
                      thickness: 1,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              AppColors.kFabColor,
                            ),
                          ),

                          onPressed: () {
                            if (_formKeys.currentState!.validate()) {
                              try {
                                noteServices.updateNote(
                                  Note(
                                    title: _noteTitleController.text,
                                    category: category,
                                    content: _noteContentController.text,
                                    date: DateTime.now(),
                                    id: widget.note.id,
                                  ),
                                );

                                AppHelpers.showSnackBar(
                                  context,
                                  "Note Updated Succesfully",
                                );
                                _noteTitleController.clear();
                                _noteContentController.clear();
                                AppRouter.router.push("/notes");
                              } catch (e) {
                                AppHelpers.showSnackBar(
                                  context,
                                  "Note Updated Error",
                                );
                              }
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Update Note",
                              style: AppTextStyles.appButton,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

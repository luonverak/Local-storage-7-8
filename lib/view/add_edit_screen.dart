import 'dart:math';

import 'package:flutter/material.dart';
import 'package:local_storage/controller/note_controller.dart';
import 'package:local_storage/model/note_model.dart';
import 'package:local_storage/view/home_screen.dart';
import 'package:local_storage/widget/colors.dart';

import '../widget/input_field.dart';

class AddEditScreen extends StatefulWidget {
  AddEditScreen({super.key, this.noteModel});
  NoteModel? noteModel;

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final title = TextEditingController();
  final description = TextEditingController();
  var time = DateTime.now();

  void update() {
    title.text = widget.noteModel!.title;
    description.text = widget.noteModel!.description;
  }

  @override
  void initState() {
    widget.noteModel == null ? const Text('') : update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarcolor,
        title: (widget.noteModel == null)
            ? const Text('Add note')
            : const Text('Edit note'),
        actions: [
          IconButton(
            onPressed: () async {
              (widget.noteModel == null)
                  ? await NoteController().insertData(
                      NoteModel(
                        id: Random().nextInt(10000),
                        title: title.text,
                        description: description.text,
                        time: "${time.year}-${time.month}-${time.day}",
                      ),
                    )
                  : await NoteController()
                      .updateData(
                        NoteModel(
                          id: widget.noteModel!.id,
                          title: title.text,
                          description: description.text,
                          time: "${time.year}-${time.month}-${time.day}",
                        ),
                      )
                      .whenComplete(
                        () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false),
                      );
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InputField(
              hindText: 'Note title',
              controller: title,
            ),
            const SizedBox(
              height: 10,
            ),
            InputField(
              hindText: 'Note decription',
              controller: description,
              maxLine: 10,
            )
          ],
        ),
      ),
    );
  }
}

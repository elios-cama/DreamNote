// ignore_for_file: prefer_const_constructors, unnecessary_this

import 'package:dreamnote/components/darkMode_bakcground.dart';
import 'package:dreamnote/components/dream_form.dart';
import 'package:dreamnote/components/gradient_background.dart';
import 'package:dreamnote/db/database_provider.dart';
import 'package:dreamnote/model/dream_model.dart';
import 'package:flutter/material.dart';

class AddEditPage extends StatefulWidget {
  final DreamModel? dream;
  final bool DarkTheme;
  const AddEditPage({
    Key? key,
    this.dream, required this.DarkTheme,
  }) : super(key: key);

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;
  late String category;

  @override
  void initState() {
    super.initState();

    title = widget.dream?.title ?? '';
    description = widget.dream?.description ?? '';
    category = widget.dream?.category ?? '';
  }

  @override
  Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
       widget.DarkTheme
            ? Gradient_WIdget()
            : DarkMode_Widget(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: AppBar(
              
              backgroundColor: Colors.transparent,
              elevation: 0,
              bottom: PreferredSize(
                  preferredSize: Size.infinite,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'lib/assets/dreamnote.png',
                          fit: BoxFit.cover,
                          height: 85,
                        ),
                      ],
                    ),
                  )),
              automaticallyImplyLeading: false,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: _formKey,
                  child: DreamFormWidget(
                    title: title,
                    category: category,
                    description: description,
                    onChangedCategory: (category) =>
                        setState(() => this.category = category.toLowerCase()),
                    onChangedTitle: (title) =>
                        setState(() => this.title = title),
                    onChangedDescription: (description) =>
                        setState(() => this.description = description),
                  ),
                ),
                
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: buildButton(),
          ),
        ),
      ],
    );
  }

  Widget buildButton() {
    Size size = MediaQuery.of(context).size;

    final isFormValid =
        title.isNotEmpty && description.isNotEmpty && category.isNotEmpty;

    
    return Container(
      width: size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Color(0xFF8942F2),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
            padding: EdgeInsets.all(17)),
        onPressed: addOrUpdateNote,
        child: Text(
          'Save',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.dream != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }
      Navigator.popAndPushNamed(context, "/homepage");

    }
  }

  Future updateNote() async {
    final dream = widget.dream!.copy(
      category: category,
      title: title,
      description: description,
    );

    await DatabaseProvider.db.update(dream);
  }

  Future addNote() async {
    final dream = DreamModel(
      title: title,
      category: category,
      description: description,
      picturepath: '',
      time: DateTime.now(),
    );

    await DatabaseProvider.db.create(dream);
  }
}


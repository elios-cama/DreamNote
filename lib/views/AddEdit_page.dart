import 'package:dreamnote/components/dream_form.dart';
import 'package:dreamnote/db/database_provider.dart';
import 'package:dreamnote/model/dream_model.dart';
import 'package:flutter/material.dart';

class AddEditPage extends StatefulWidget {
  final DreamModel? dream;
  const AddEditPage({
    Key? key,
    this.dream,
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
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black12,
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: DreamFormWidget(
            category: category,
            title: title,
            description: description,
            onChangedCategory: (category) => setState(() =>this.category = category),
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) =>
                setState(() => this.description = description),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty && category.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: Text('Save'),
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

      Navigator.of(context).pop();
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
      time : DateTime.now(),
    );

    await DatabaseProvider.db.create(dream);
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DreamFormWidget extends StatelessWidget {
  
  final String? title;
  final String? description;
  final String? category;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final ValueChanged<String> onChangedCategory;

  const DreamFormWidget({
    Key? key,
    
    this.title = '',
    this.description = '',
    this.category = '',
    
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildTitle(),
                SizedBox(height: 25),
                buildCategory(),
                SizedBox(height: 9),
                buildDescription(),
                
                
          
              ],
            ),
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        maxLength: 20,
        initialValue: title,
        style: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
          hintText: 'Enter a title',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 50,
        initialValue: description,
        style: TextStyle(color: Colors.white60, fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );

       Widget buildCategory() => TextFormField(
        maxLines: 1,
        
        maxLength: 12,
        initialValue: category,
        style: TextStyle(color: Colors.white60, fontSize: 18),
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
          hintText: 'friends, love, family...',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (category) => category != null && category.isEmpty
            ? 'The category cannot be empty'
            : null,
        onChanged: onChangedCategory,
      );
}


 
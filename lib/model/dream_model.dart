// ignore_for_file: prefer_const_declarations

final String tableDreams = 'dreams';

class DreamField {

  static final List<String> values = [
    id, title, description, picturepath, category,time,
  ];

  static final String id = '_id';
  static final String title = '_title';
  static final String description = '_description';
  static final String picturepath = '_pciturepath';
  static final String category = '_category';
  static final String time = '_time';
}









class DreamModel {
  int? id;
  String title;
  String description;
  String picturepath;
  String category;
  DateTime time;

  DreamModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.picturepath,
      required this.category,
      required this.time});

  Map<String, dynamic> toMap() => {
        DreamField.id: id,
        DreamField.title: title,
        DreamField.description: description,
        DreamField.picturepath: picturepath,
        DreamField.category: category,
        DreamField.time: time.toIso8601String(),
      };

  static DreamModel fromJson(Map<String, Object?> json) => DreamModel(
    id: json[DreamField.id] as int?,
    title : json[DreamField.title] as String,
    description : json[DreamField.description] as String,
    picturepath : json[DreamField.picturepath] as String,
    category : json[DreamField.category] as String,
    time : DateTime.parse(json[DreamField.time] as String),
  );


  DreamModel copy({
    int? id,
    String? title,
    String? description,
    String? picturepath, 
    String? category,
    DateTime? time
  }) =>
      DreamModel(
          id: id ?? this.id,
          title: title?? this.title,
          description: description?? this.description,
          picturepath: picturepath?? this.picturepath,
          category: category?? this.category,
          time: time?? this.time
          );
}

class ToDOModel {
  final int id;
  final String title;
  final String description;
  final String time;
  final int favorite;
  final int completed;

  ToDOModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.favorite,
    required this.completed,
  });

  factory ToDOModel.fromJson(Map<String, dynamic> json) {
    return ToDOModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      time: json['time'],
      favorite: json['favorite'],
      completed: json['completed'],
    );
  }
}

class FileChange {
  int id;
  String filename;
  String path;
  String date;
  String time;
  String type;
  String branch;
  String app;

  FileChange({
    required this.id,
    required this.filename,
    required this.path,
    required this.date,
    required this.time,
    required this.type,
    required this.branch,
    required this.app,
  });

  factory FileChange.fromJson(Map<String, dynamic> json) {
    return FileChange(
      id: json['id'],
      filename: json['filename'],
      path: json['path'],
      date: json['date'],
      time: json['time'],
      type: json['type'],
      branch: json['branch'],
      app: json['app'],
    );
  }
}

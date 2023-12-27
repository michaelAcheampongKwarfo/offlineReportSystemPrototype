class FileChange {
  int id;
  String filename;
  String path;
  String timestamp;
  String type;
  String branch;
  String app;

  FileChange({
    required this.id,
    required this.filename,
    required this.path,
    required this.timestamp,
    required this.type,
    required this.branch,
    required this.app,
  });

  factory FileChange.fromJson(Map<String, dynamic> json) {
    return FileChange(
      id: json['id'],
      filename: json['filename'],
      path: json['path'],
      timestamp: json['timestamp'],
      type: json['type'],
      branch: json['branch'],
      app: json['app'],
    );
  }
}

// To parse this JSON data, do
//
//     final fileModel = fileModelFromJson(jsonString);

import 'dart:convert';

List<FileModel> fileModelFromJson(String str) => List<FileModel>.from(json.decode(str).map((x) => FileModel.fromJson(x)));

String fileModelToJson(List<FileModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FileModel {
  String? name;
  String? content;
  String? ext;

  FileModel({
    this.name,
    this.content,
    this.ext,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
    name: json["name"],
    content: json["content"],
    ext: json["ext"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "content": content,
    "ext": ext,
  };
}

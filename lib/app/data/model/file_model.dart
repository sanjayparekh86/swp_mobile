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
  String? username;
  String? password;

  FileModel({
    this.name,
    this.content,
    this.ext,
    this.username,
    this.password,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
    name: json["name"],
    content: json["content"],
    ext: json["ext"],
    username: json["username"],
    password: json['password']
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "content": content,
    "ext": ext,
    "username": username,
    "password": password
  };
}

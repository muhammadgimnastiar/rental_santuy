import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/article.dart';

class Articles extends ChangeNotifier {
  String urlMaster = "http://10.0.2.2:8000";

  String? token;

  List<Article> _allArticle = [];
  List<Article> get allArticle => _allArticle;

  Future<void> inisialData() async {
    Uri url = Uri.parse("$urlMaster/api/v1/berita/");
    print(token);
    try {
      var response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      });

      List<dynamic> dataArticles;
      if (response.statusCode >= 300 && response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        var data = json.decode(response.body) as Map<String, dynamic>;

        dataArticles = data["data"];
        for (int i = 0; i < dataArticles.length; i++) {
          Article article = Article(
              id: dataArticles[i]["id"].toString(),
              title: dataArticles[i]["judul"],
              image: dataArticles[i]["picture"],
              content: dataArticles[i]["content"]);
          _allArticle.add(article);
        }
      }
    } catch (err) {
      throw (err);
    }
  }

  Future<void> login(String email, String password) async {
    Uri url = Uri.parse("$urlMaster/api/v1/auth/login");
    try {
      var response = await http.post(url,
          body: json.encode({
            "email": email,
            "password": password,
          }),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          });

      if (response.statusCode >= 300 && response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        token = json.decode(response.body)["access_token"].toString();
        notifyListeners();
      }
    } catch (err) {
      throw (err);
    }
  }

  //Add article
  Future<void> addArticle(String title, String image, String content) async {
    Uri url = Uri.parse("$urlMaster/api/v1/berita/");
    try {
      var response = await http.post(url,
          body: json.encode({
            "judul": title,
            "picture": image,
            "content": content,
            "kategori_id": 1,
            // "token": token,
          }),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          });

      if (response.statusCode > 300 || response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        Article data = Article(
          id: json.decode(response.body)["data"]["id"].toString(),
          title: title,
          image: image,
          content: content,
        );
        _allArticle.add(data);
        notifyListeners();
      }
    } catch (err) {
      throw (err);
    }
  }

  //Edit Article
  void editArticle(
      String id, String title, String image, String content) async {
    Uri url = Uri.parse("$urlMaster/api/v1/berita/$id/");
    DateTime date = DateTime.now();
    try {
      var response = await http.patch(url,
          body: json.encode({
            "judul": title,
            "picture": image,
            "content": content,
            "kategori_id": 1,
            "created_at": date.toString(),
          }),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          });

      if (response.statusCode > 300 || response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        Article edit = _allArticle.firstWhere((element) => element.id == id);
        edit.title = title;
        edit.image = image;
        notifyListeners();
        print("ini data yg diapdare ${edit.title}");
      }
    } catch (err) {
      throw (err);
    }
  }

  //Edit Article
  void deleteArticle(String id) async {
    Uri url = Uri.parse("$urlMaster/api/v1/berita/$id/");
    DateTime date = DateTime.now();
    try {
      var response = await http.delete(url, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      });

      if (response.statusCode > 300 || response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        Article edit = _allArticle.firstWhere((element) => element.id == id);
        _allArticle.removeWhere((element) => element.id == id);
        notifyListeners();
        print("Data ke-$id berhasil diremove${edit.title}");
      }
    } catch (err) {
      throw (err);
    }
  }

  Article selectById(String id) {
    return _allArticle.firstWhere((element) => element.id == id);
  }
}
//Future<void> addArticle()

Future<void> main(List<String> args) async {
  Articles article = Articles();

  await article.login("adagimnas@gmail.com", "Gimnasada3*");

  article.inisialData();
  article.addArticle(
      "ini Title dari method add article",
      "https://img-global.cpcdn.com/recipes/a6f3bd2872e44815/1200x630cq70/photo.jpg",
      "Content brooo");

  article.editArticle(
      '7',
      "ini Title dari method EDIT article",
      "https://img-global.cpcdn.com/recipes/a6f3bd2872e44815/1200x630cq70/photo.jpg",
      "Content brooo");
}

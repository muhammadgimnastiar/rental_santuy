import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_santuy/services/articles.dart';
import 'package:rental_santuy/style/colors.dart';

class EditArticlePage extends StatelessWidget {
  static const route = "/edit-article";

  @override
  Widget build(BuildContext context) {
    String prodId = ModalRoute.of(context)?.settings.arguments as String;

    var prov = Provider.of<Articles>(context, listen: false);

    var selectedProduct = prov.selectById(prodId);

    final TextEditingController titleController =
        TextEditingController(text: selectedProduct.title);
    final TextEditingController imageController =
        TextEditingController(text: selectedProduct.image);
    final TextEditingController contentController =
        TextEditingController(text: selectedProduct.content);

    void edit(String title, String image, String content) {
      try {
        prov.editArticle(prodId, title, image, content);
      } catch (e) {
        if (e == 401) {
          Navigator.pushNamed(context, '/login');
        }
      }
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Article"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => edit(titleController.text, imageController.text,
                contentController.text),
          ),
        ],
        backgroundColor: MyColors.orangeSld,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextField(
                  autocorrect: false,
                  autofocus: true,
                  controller: titleController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  autocorrect: false,
                  controller: imageController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: "Image",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  autocorrect: false,
                  controller: contentController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: "Content",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 30),
              child: ElevatedButton(
                onPressed: () => edit(titleController.text,
                    imageController.text, contentController.text),
                child: Text(
                  "Edit",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    primary: MyColors.orangeSld),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

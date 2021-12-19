import 'package:flutter/cupertino.dart';

class News with ChangeNotifier{
  final int? id;
  final String? title;
  final String? link;
  final String? description;
  final String? published;
  var isFavourites = false;
  News({required this.description,required this.id,required this.link,required this.published,required this.title});
  void toggle(){
    isFavourites = !isFavourites;
    notifyListeners();
  }
}
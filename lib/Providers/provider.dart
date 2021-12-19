import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'news.dart';

class Providers with ChangeNotifier{

  List<News>favouritesList = [];
  void add(News news){

  for(int i = 0 ; i  < favouritesList.length ; i++){
    if(favouritesList[i].id == news.id){
      favouritesList.removeAt(i);
      notifyListeners();
      return;
    }
  }
    favouritesList.add(news);

    notifyListeners();
  }

}
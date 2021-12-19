import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:news_app/widgets/card.dart';
import 'package:provider/provider.dart';
import 'Providers/news.dart';
import 'Providers/provider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Providers(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  MyHomePage(),
      ),
    );
  }
}
Future<Map<String,dynamic>> fetchData() async {
  String link = "https://api.first.org/data/v1/news";
  Response response = await get(Uri.parse(link));
  if(response.statusCode == 200){
    return jsonDecode(response.body);
  }
  else{
    throw Exception("Not found");
  }
}
class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isFavourites = false;
  bool seen = false;
  Future? data;
   List<News>items = [];
  // List<News>favouritesList = [];
  @override
  void initState() {
    // TODO: implement initState
     data = fetchData();
    data?.then((value) {
     var news = value["data"];
     print(news);
    for(int i = 0 ; i < news.length ; i++){
      items.add(News(
        id: news[i]["id"],
        description: news[i]["summary"],
        title: news[i]["title"],
        link: news[i]["link"],
        published: news[i]["published"]
      ));
    }
     setState(() {
       seen = true;
     });
    });

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    final favouritesList = Provider.of<Providers>(context,listen: false);

    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(0.92),
      body: (seen == false)?Center(child: CircularProgressIndicator()):
          Column(
            children:[ Expanded(
              child: ListView.builder(
                itemCount: isFavourites == false?items.length : favouritesList.favouritesList.length,
                  itemBuilder: (context,index){
                  return ChangeNotifierProvider.value (
                    value: items[index],
                    child: CardViews(
                      news: isFavourites == false ? items[index] : favouritesList.favouritesList[index],
                    ),
                  );
              }),
            ),
              Row(
                children:[
              Flexible(
              child:
                  InkWell(
                    onTap: (){
                      setState(() {
                        isFavourites = !isFavourites;
                      });
                    },
                    child: Container(

                    margin: EdgeInsets.only(left: 10.0,right: 5.0,top:10.0),
                    height: 50,
                    child: Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Icon(Icons.menu,color: isFavourites == false?Colors.white:Colors.black,size: 30,),
                      SizedBox(width: 10.0,),
                      Text('News',style: TextStyle(color: isFavourites == false?Colors.white:Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),

    ]),),
                    width: MediaQuery.of(context).size.width*0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight:Radius.circular(10.0) ),
                      color:  isFavourites == false?Colors.deepPurple:Colors.white

                    ),

                ),
                  ),
              ),
                  Flexible(
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          isFavourites = !isFavourites;
                        });

                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(right: 10.0,left: 5.0,top:10.0),
                        child: Center(child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children:[
                          Icon(Icons.favorite,color: Colors.red,size: 35,),
                              SizedBox(width: 10.0,),
                          Text('Favs',style: TextStyle(color:  isFavourites == false?Colors.black:Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),

    ]),),
                        width: MediaQuery.of(context).size.width*0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight:Radius.circular(10.0) ),
                          color:isFavourites == false?Colors.white:Colors.deepPurple
                        ),

                      ),
                    ),
                  ),

    ]
              )
      ]
          )
    );
  }
}

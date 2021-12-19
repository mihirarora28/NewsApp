import 'package:flutter/material.dart';
import 'package:news_app/Providers/news.dart';
import 'package:news_app/Providers/provider.dart';
import 'package:provider/provider.dart';
class CardViews extends StatelessWidget {
  final News news;
  CardViews({required this.news});
  @override
  Widget build(BuildContext context) {
       final value = Provider.of<News>(context,listen: true);
       final values = Provider.of<Providers>(context,listen: true);
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 2.0,horizontal: 2.0),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Card(
          elevation: 5.0,
          child: Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 30.0), child: IconButton(onPressed: (){
                 print('YES');
                 news.toggle();
                values.add(news);

              }, icon:( news.isFavourites == false)?Icon(Icons.favorite_outline_outlined,color: Colors.black38,size: 50.0,):(Icon(Icons.favorite,color: Colors.red,size: 50.0,)))),
              Spacer(),
              Column(
                children: [
                  // Text(Title.toString()),
                   Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width*0.6,

                      child: Text(Title == null ? " ": news.title.toString(), maxLines: 2,
                        style: TextStyle(fontWeight: FontWeight.bold),

                        overflow: TextOverflow.ellipsis,

                      ),

                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width*0.6,
                      child: Text((news.description.toString().length == 0) ? " ":news.description.toString(), maxLines: 3,
                        style: TextStyle(fontWeight: FontWeight.normal),

                        overflow: TextOverflow.ellipsis,

                      ),

                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width*0.6,

                      child: Text(news.published == null ? " ":news.published.toString(), maxLines: 1,

                        style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black54),

                        overflow: TextOverflow.ellipsis,

                      ),

                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

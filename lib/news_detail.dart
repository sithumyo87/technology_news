import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:news/technology.dart';

class NewsDetail extends StatelessWidget {
  final Items item;
  const NewsDetail({super.key,required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News Detail",style: TextStyle(fontSize: 14),)),
      body: SingleChildScrollView(
        child: Container(  
          child: Column(children: [
            Hero(tag:item.enclosure!.link!,child: Image.network(item.enclosure!.link!)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: 15,),
                   Text(item.author!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.red),),
                   Text("Date - ${item.pubDate!}",style: TextStyle(fontSize: 12,),),
                    SizedBox(height: 15,),
              Text("Category - ${item.categories!.join(',')}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
               SizedBox(height: 30,),
              Text(item.description!,style: TextStyle(fontSize: 12,))
                ],
              ),
            ),
           
          ],),
        ),
      ),
    );
  }
}
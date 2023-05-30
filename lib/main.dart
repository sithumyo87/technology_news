import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news/news_detail.dart';
import 'package:news/technology.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    theme: ThemeData(primarySwatch: Colors.red),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String baseUrl =
      "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.voanews.com%2Fapi%2Fzyritequir";

  Future<List<Items>?> getNews() async {
    Uri uri = Uri.parse(baseUrl);
    var responeStr = await http.get(uri);
    // print(responeStr.body);
    var respone = jsonDecode(responeStr.body);
    Technology tech = Technology.fromJson(respone);
    // print(tech);
    return tech.items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Technology News",style: TextStyle(fontSize: 16),),actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.settings),),
        ],),
        body:FutureBuilder(builder: (BuildContext context,AsyncSnapshot snapshot) {
            if(snapshot.data == null){
              return Center(child: 
              CircularProgressIndicator(),);
            }else{
              List<Items> items = snapshot.data;
              return ListView(
                children: items.map((i){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return  NewsDetail(item: i,);
                        }));
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 9,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                ClipRRect(child: Hero(tag: i.enclosure!.link!,child: Image.network(i.enclosure!.link!)),borderRadius: BorderRadius.circular(10),),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                  child: Text(i.title!),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            
            }
          },future: getNews(),)
        );
  }
}

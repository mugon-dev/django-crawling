import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/deal.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<List<Deal>> fetchDeals() async {
    List<Deal> deals = [];
    var url = Uri.parse("http://127.0.0.1:8000/api/deals/");
    var response = await http.get(url);
    var data = json.decode(utf8.decode(response.bodyBytes));
    data.forEach((e) {
      Deal deal = Deal.fromJson(e);
      deals.add(deal);
    });
    return deals;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.indigo),
      home: Scaffold(
          appBar: AppBar(
            title: Text("hotdeal"),
          ),
          body: FutureBuilder<List<Deal>>(
            future: fetchDeals(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  padding: EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    Deal deal = snapshot.data![index];
                    return ListTile(
                      onTap: () {
                        launch(deal.link as String);
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(deal.imageUrl as String),
                      ),
                      title: Text(deal.title as String),
                      trailing: Text(deal.upCount.toString()),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text("no hot deal"),
                );
              }
            },
          )),
    );
  }
}

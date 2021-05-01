import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

const String MORE_APPS =
    "https://raw.githubusercontent.com/Hakim-Allaoui/More_apps/main/index.json";

class MoreApps extends StatefulWidget {
  @override
  _MoreAppsState createState() => _MoreAppsState();
}

class _MoreAppsState extends State<MoreApps> {
  List<FeaturedApp> _appsList = [];
  Widget _body = CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  Expanded(
                      child: Text(
                    'Featured Apps',
                    style: TextStyle(fontSize: 21.0),
                    textAlign: TextAlign.center,
                  )),
                  IconButton(
                    onPressed: null,
                    icon: SizedBox(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _appsList.length > 0 ? _buildBody() : Center(child: _body),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: getData,
      child: ListView.builder(
        itemCount: _appsList.length,
        itemBuilder: (BuildContext ctx, index) {
          return InkWell(
            onTap: () async {
              String url = _appsList[index].url;
              try {
                await launch(url);
              } catch (e) {
                print('Could not launch $url, error: $e');
              }
            },
            child: Card(
              elevation: 8,
              child: Row(
                children: [
                  SizedBox(
                    height: 80.0,
                    width: 80.0,
                    child: ClipRRect(
                      child: Image.network(
                        _appsList[index].iconUrl,
                        height: 80.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          Text(
                            _appsList[index].title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow[600],
                                    size: 20.0,
                                  ),
                                  Text(_appsList[index].rating.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0,
                                      )),
                                ],
                              ),
                              Expanded(
                                child: Text(
                                  "${index + 1}# trending",
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.red),
                                  textAlign: TextAlign.end,
                                ),
                              )
                            ],
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<List<FeaturedApp>> getData() async {
    setState(() {
      _body = CircularProgressIndicator();
    });
    final response = await http.get(Uri.parse(MORE_APPS));
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var values = json.decode(response.body);
      print(values);
      setState(() {
        _appsList = List<FeaturedApp>.from(
            values.map((model) => FeaturedApp.fromJson(model)));
      });
      setState(() {});
      return _appsList;
    } else {
      // If that call was not successful, throw an error.
      setState(() {
        _body = Text('No Data');
      });
      throw Exception('Failed to load post');
    }
  }
}

class FeaturedApp {
  String title;
  String url;
  String iconUrl;
  double rating;

  FeaturedApp({this.title, this.url, this.iconUrl, this.rating});

  factory FeaturedApp.fromJson(Map<String, dynamic> json) {
    return FeaturedApp(
      title: json["title"],
      url: json["url"],
      iconUrl: json["icon_url"],
      rating: double.parse(json["rating"].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "url": this.url,
      "icon_url": this.iconUrl,
      "rating": this.rating,
    };
  }
//

}

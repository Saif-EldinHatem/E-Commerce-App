import 'dart:convert';
import 'package:eCommerce/data.dart';
import 'package:eCommerce/detailsscreen.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'global.dart';

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<bool> isFavoriteList = [];

  //sqflite========================
  Future<void> getData() async {
    //to retrieve data from database
    try {
      final newData = await sqlDb.readData(
              "SELECT * FROM FavoriteItems WHERE userId = ${Global.currentId}")
          as List<Map<String, dynamic>>;

      setState(() {
        Global.favoritesList =
            newData.map((item) => Map<String, dynamic>.from(item)).toList();
      });
    } catch (e) {
      print("Database error: $e");
    }
  }

  void _toggleFavorite(int cardIndex) async {
    final isFavorite = isFavoriteList[cardIndex];
    if (isFavorite) {
      await sqlDb
          .deleteData("DELETE FROM FavoriteItems WHERE itemid = $cardIndex");
    } else {
      await sqlDb.insertData(
          "INSERT INTO FavoriteItems (userid, itemid, favorite) VALUES (${Global.currentId}, $cardIndex, 1)");
    }

    //toggling button in UI
    setState(() {
      isFavoriteList[cardIndex] = !isFavorite;
    });
  }

  @override
  void initState() {
    super.initState();
    if (Global.Data.isEmpty) fetchapi();
    if (Global.favoritesList.isEmpty) getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(" HOME ",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
          backgroundColor: const Color.fromARGB(255, 180, 209, 253),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Column(children: [
                      Container(
                        height: 150,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/image3.jpg'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                              bottomLeft: Radius.circular(32),
                              bottomRight: Radius.circular(32),
                            )),
                      ),
                    ]),
                    const SizedBox(
                      height: 12,
                    ),
                    const Row(children: [
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      Text(
                        "ViewAll",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(126, 126, 126, 1),
                        ),
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                    ]),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        MaterialButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0)),
                          height: 32,
                          minWidth: 20,
                          color: const Color.fromARGB(255, 180, 209, 253),
                          child: const Text(
                            "All",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.normal),
                          ),
                        ),
                        const Spacer(),
                        MaterialButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0)),
                          height: 32,
                          minWidth: 20,
                          color: const Color.fromARGB(255, 180, 209, 253),
                          child: const Text(
                            "Electronics",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.normal),
                          ),
                        ),
                        const Spacer(),
                        MaterialButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0)),
                          height: 32,
                          minWidth: 20,
                          color: const Color.fromARGB(255, 180, 209, 253),
                          child: const Text(
                            "Perfumes",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.normal),
                          ),
                        ),
                        const Spacer(),
                        MaterialButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22.0)),
                          height: 32,
                          minWidth: 2,
                          color: const Color.fromARGB(255, 180, 209, 253),
                          child: const Text(
                            "Others",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: Global.Data.length,
                        itemBuilder: (context, index) {
                          isFavoriteList.add(Global.favoritesList.any(
                              (favorite) =>
                                  favorite['itemId'] == (index) &&
                                  favorite['userId'] == Global.currentId));

                          return Card(
                            elevation: 2,
                            clipBehavior: Clip.antiAlias,
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [
                                Image.network(
                                  Global.Data[index].thumbnail,
                                  fit: BoxFit.fitWidth,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      flex: 24,
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          Global.Data[index].title,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    const Spacer(
                                      flex: 8,
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          _toggleFavorite(index);
                                        },
                                        icon: Icon(
                                          isFavoriteList[index]
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.red,
                                        )),
                                    SizedBox(
                                      width: 64,
                                      child: MaterialButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      detailsscreen(
                                                          Global.Data[index])));
                                        },
                                        shape: const StadiumBorder(),
                                        height: 32,
                                        minWidth: 30,
                                        color: const Color.fromARGB(
                                            255, 180, 209, 253),
                                        child: const Text(
                                          "VIEW",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ),
                                    const Spacer(flex: 2),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                  ]),
            ),
          ),
        ));
  }

  Future<void> fetchapi() async {
    const url = 'https://dummyjson.com/products';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['products'] as List<dynamic>;
    final transformed = results.map((e) {
      return data(
          id: e['id'],
          thumbnail: e['thumbnail'],
          title: e['title'],
          description: e['description'],
          price: e['price'],
          discountPercentage: e['discountPercentage'],
          // rating: e['rating'] ?? 0.0,
          images: e['images'],
          brand: e['brand']);
    }).toList();

    setState(() {
      Global.Data = transformed;
    });
  }
}

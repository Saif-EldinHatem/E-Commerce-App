// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:eCommerce/detailsscreen.dart';
import 'package:eCommerce/emptyPage.dart';
import 'package:eCommerce/global.dart';
import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  //sqflite======================

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
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
    int itemId = Global.favoritesList[cardIndex]['itemId'];
    bool isFavorite = Global.favoritesList[cardIndex]['favorite'] == 1;

    if (isFavorite) {
      await sqlDb
          .deleteData("DELETE FROM FavoriteItems WHERE itemid = $itemId");
    } else {
      await sqlDb.insertData(
          "INSERT INTO FavoriteItems (userid, itemid, favorite) VALUES (${Global.favoritesList[cardIndex]['userId']}, $itemId, 1)");
    }

    //toggling button in UI
    setState(() {
      Global.favoritesList[cardIndex]['favorite'] = isFavorite ? 0 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(209, 52, 51, 1),
        title: Text(
          "Favorites",
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: getData,
        child: Padding(
            padding: const EdgeInsets.all(8.5),
            child: Global.favoritesList.isEmpty
                ? EmptyPage()
                : ListView.builder(
                    itemCount: Global.favoritesList.length,
                    itemBuilder: (context, index) {
                      var itemId = Global.favoritesList[index]['itemId'];
                      return GestureDetector(
                        onTap: () {
                          itemId = Global.favoritesList[index]['itemId'];

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    detailsscreen(Global.Data[itemId]),
                              ));
                        },
                        child: Container(
                          height: 150,
                          margin: EdgeInsets.only(top: 6.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child: Card(
                              color: Colors.grey.shade200,
                              elevation: 4.0,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 120,
                                    height: double.infinity,
                                    child: Image.network(
                                      Global.Data[itemId].thumbnail,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ), //check width

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            Global.Data[itemId].title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              fontFamily: 'Poppins',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          Global.Data[itemId].brand,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              color: Color.fromRGBO(
                                                  45, 49, 49, 0.9)),
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: SizedBox(
                                            height: 40,
                                            child: Text(
                                              Global.Data[itemId].description,
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'Poppins',
                                                color: Color.fromRGBO(
                                                    45, 49, 49, 0.6),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                _toggleFavorite(index);
                                                print(
                                                    "index: $index, favorite new: ${Global.favoritesList[index]['favorite']}");
                                              },
                                              icon: Global.favoritesList[index]
                                                          ['favorite'] ==
                                                      1
                                                  ? Icon(Icons.favorite)
                                                  : Icon(Icons.favorite_border),
                                              color: Colors.redAccent[700],
                                              padding:
                                                  EdgeInsets.only(left: 0.0),
                                            ),
                                            Spacer(
                                              flex: 2,
                                            ),
                                            Flexible(
                                              flex: 9,
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: OutlinedButton(
                                                  onPressed: () {},
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                          foregroundColor:
                                                              Color.fromRGBO(
                                                                  209,
                                                                  52,
                                                                  51,
                                                                  1),
                                                          side: BorderSide(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      209,
                                                                      52,
                                                                      51,
                                                                      1)),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          )),
                                                  child: Text("Add To Cart"),
                                                ),
                                              ),
                                            ),
                                            Spacer(
                                              flex: 1,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
      ),
    );
  }
}

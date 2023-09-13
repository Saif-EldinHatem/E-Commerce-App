import 'package:eCommerce/data.dart';
//import 'dart:convert';
//import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class detailsscreen extends StatelessWidget {
  final data details;
  detailsscreen(this.details);
  //const detailsscreen({Key? key,required this.details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(247, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "PRODUCT DETAILS",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 180, 209, 253),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: details.images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Image.network(
                        details.images[index],
                        fit: BoxFit.scaleDown,
                        width: MediaQuery.of(context).size.width - 30,
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              details.title,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 19),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(details.description),
            const SizedBox(height: 10),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            Text(
              'Brand: ${details.brand}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            Text(
              'Price: ${details.price}',
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.green),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            MaterialButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0)),
              height: 32,
              minWidth: 20,
              color: const Color.fromARGB(255, 180, 209, 253),
              child: const Text(
                "Add to cart",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*Future <void> fetchapi() async
{
  const url = 'https://dummyjson.com/products';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  final body = response.body;
  final json = jsonDecode(body);
  final results = json['products'] as List<dynamic>;
  final transformed = results.map((e)
  {
    return data(
        thumbnail: e['thumbnail'],
        title: e['title'],
        description: e['description'],
      price: e['price'],
      discountPercentage: e['discountPercentage'],
      rating: e['rating'],
      images: e['images'],
    );
  }).toList();

}*/


import 'package:eCommerce/nav_bar.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Image.asset("assets/images/not_found.png"),
          Text(
            "No Items Found",
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(209, 52, 51, 0.9)),
          ),
          SizedBox(
            height: 100,
          ),
          SizedBox(
              width: 300,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(209, 52, 51, 1))),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => PageNavigator(),
                  ));
                },
                child: Text("Home"),
              )),
        ],
      ),
    );
  }
}

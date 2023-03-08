import 'package:chalkboard/Screens/drawingboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DrawingBoard(),
                ),
              );
            },
            child: Container(
              height: 100,
              width: 100,
              color: Colors.red,
            ),
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.green,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.blue,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.yellow,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.purple,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.orange,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.pink,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.brown,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.black,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.white,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.grey,
          ),
          Container(
            height: 100,
            width: 100,
            color: Colors.teal,
          ),
        ],
      ),
    );
  }
}

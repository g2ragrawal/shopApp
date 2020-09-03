import 'package:flutter/material.dart';
import 'package:jain_namkin/model/search_model.dart';

class OffersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                height: 32,
                width: 32,
                child: Center(
                  child: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      padding: const EdgeInsets.all(0),
                      onPressed: () {Scaffold.of(context).openDrawer();}),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              Text(
                'Offers',
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                width: 50,
              ),
              IconButton(icon: Icon(Icons.search), onPressed: () {showSearch(context: context, delegate: DataSearch());}),
            ],
          ),
        ],
      )),
    );
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jain_namkin/model/search_model.dart';
import 'package:jain_namkin/provider/auth_provider.dart';
import 'package:jain_namkin/provider/order_provider.dart';
import 'package:jain_namkin/provider/product_provider.dart';
import 'package:jain_namkin/widgets/popular_item_widget.dart';
import 'package:jain_namkin/widgets/product_card_widget.dart';
import 'package:jain_namkin/widgets/suggstion_item_widget.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider =Provider
        .of<Products>(context);
    final products = productProvider
        .item;
    final _first= Provider.of<Auth>(context).first;

    String greeting() {
      var hour = DateTime.now().hour;
      if (hour >6 && hour < 12) {
        return 'Morning';
      }
      if (hour >6 && hour < 16) {
        return 'Afternoon';
      }
      if(hour >6 && hour <19){
        return 'Evening';
      }
      return 'Night';
    }
    String _greet = greeting();
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 12, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    'New Jain Farsan',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        showSearch(context: context, delegate: DataSearch());
                      }),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Hi, ${_first}',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'Good ${_greet}.',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Suggestions for you',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 4.6,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx,index){return SuggestionCard(title: Provider.of<OrderProvider>(context).suggestionList[index].title,imageUrl: Provider.of<OrderProvider>(context).suggestionList[index].imageURL,productId: Provider.of<OrderProvider>(context).suggestionList[index].id,);},
                      itemCount: Provider.of<OrderProvider>(context).suggestionList.length,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Popular of week',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 4.5,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx,index){return PopularCard(title: Provider.of<OrderProvider>(context).suggestionList[index].title,imageUrl: Provider.of<OrderProvider>(context).suggestionList[index].imageURL,productId: Provider.of<OrderProvider>(context).suggestionList[index].id,);},
                      itemCount: Provider.of<OrderProvider>(context).popularList.length,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Browse Categories',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: (){Navigator.of(context).pushNamed('categoryScreen',arguments: 'bakery');},
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                'https://cdn.pixabay.com/photo/2020/05/01/09/13/cupcakes-5116009_960_720.jpg',
                              ),
                              radius: 30,
                            ),
                            Text('Bakery'),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){Navigator.of(context).pushNamed('categoryScreen',arguments: 'sweet');},
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2014/12/22/12/33/sweets-577230_960_720.jpg'),
                              radius: 30,
                            ),
                            Text('Sweets')
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: (){Navigator.of(context).pushNamed('categoryScreen',arguments: 'farsan');},
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2017/05/06/19/20/indian-2290593_960_720.jpg'),
                              radius: 30,
                            ),
                            Text('Farsan'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Products',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(height: MediaQuery
                      .of(context)
                      .size
                      .height / 1.5,
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                      child: ListView.builder(itemBuilder: (context, index) =>
                          ProductCard(product: products[index]),
                        itemCount: products.length,)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


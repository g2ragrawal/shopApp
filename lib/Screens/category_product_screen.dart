import 'package:flutter/material.dart';
import 'package:jain_namkin/model/search_model.dart';
import 'package:jain_namkin/provider/product_provider.dart';
import 'package:jain_namkin/widgets/product_card_widget.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    var category=ModalRoute.of(context).settings.arguments as String;
    List _catItem=[];
    productProvider
        .item.forEach((element) {if(element.category==category){_catItem.add(element);}});
    return Scaffold(
      body: SafeArea(
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
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                          padding: const EdgeInsets.all(0),
                          onPressed: (){
                            _catItem=[];
                            Navigator.pop(context);
                          }),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    'My shop',
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
              Expanded(
                child: Column(
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
                    Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                        child: ListView.builder(
                          itemBuilder: (context, index) =>
                              ProductCard(product: _catItem[index]),
                          itemCount: _catItem.length,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

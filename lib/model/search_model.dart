import 'package:flutter/material.dart';
import 'package:jain_namkin/model/product_item.dart';
import 'package:jain_namkin/provider/product_provider.dart';
import 'package:provider/provider.dart';

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ProductItem> _items = Provider.of<Products>(context).item;
    // TODO: implement buildSuggestions
    final suggestionList = query.isNotEmpty
        ? _items
            .where((element) =>
                element.title.toLowerCase().contains(query.toLowerCase()))
            .toList()
        : [];
    int getStartIndex(String input) {
      return input.toLowerCase().indexOf(query.toLowerCase());
    }

    return ListView.builder(
      itemBuilder: (context, index) => InkWell(
        onTap: (){Navigator.of(context).pushNamed('/productItem',arguments: suggestionList[index].id);},
        child: Card(
          child: Row(children: <Widget>[
            Expanded(child: Container(height: 100,decoration: BoxDecoration(image: DecorationImage(image:NetworkImage(suggestionList[index].imageURL))),margin: EdgeInsets.only(left: 8),),flex: 1,),
              Expanded(
                flex: 2,
                child: Center(
                  child: RichText(
            text: TextSpan(
                    text: suggestionList[index].title
                        .substring(0, getStartIndex(suggestionList[index].title)),
                    style: TextStyle(color: Colors.grey[600]),
                    children: [
                      TextSpan(
                          text: suggestionList[index].title.substring(
                              getStartIndex(suggestionList[index].title),
                              getStartIndex(suggestionList[index].title) + query.length),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold)),
                      TextSpan(
                        text: suggestionList[index].title.substring(
                            getStartIndex(suggestionList[index].title) + query.length),
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ]),
          ),
                ),
              )],),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}

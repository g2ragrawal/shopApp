import 'package:flutter/material.dart';
class SuggestionCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String productId;
  SuggestionCard({this.title,this.imageUrl,this.productId});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed('/productItem',arguments: productId);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2.2,
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),boxShadow: [BoxShadow(color: Colors.black.withOpacity(.1),spreadRadius: 2,blurRadius: 3)]),
        margin:
        EdgeInsets.only(top: 10, right: 10, bottom: 10),
        child: Column(
          children: <Widget>[
            Expanded(child: Container(decoration:BoxDecoration(image: DecorationImage(image: NetworkImage(imageUrl),fit: BoxFit.fill),borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10))),),flex: 7,),
            Expanded(child: Center(child: Text(title)),flex: 2,),

          ],
        ),
      ),
    );
  }
}
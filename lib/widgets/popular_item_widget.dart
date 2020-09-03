import 'package:flutter/material.dart';

class PopularCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String productId;

  PopularCard({this.imageUrl, this.title, this.productId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed('/productItem',arguments: productId);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 2.5,
        margin: EdgeInsets.only(right: 8, bottom: 8, left: 8),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.1), spreadRadius: 2, blurRadius: 3)
        ], borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(imageUrl), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(8)),
              ),
              flex: 6,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(title),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.amber,
                      ),
                    ],
                  )
                ],
              ),
              flex: 2,
            ),
          ],
        ),
        padding: EdgeInsets.all(8),
      ),
    );
  }
}

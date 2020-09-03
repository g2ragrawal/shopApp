import 'package:flutter/material.dart';

class ProductItem{
  @required final String id;
  @required final String title;
  @required final Map<String,dynamic> weights;
  final String category;
  final String imageURL;
  final String description;

  ProductItem({this.title,this.id,this.weights,this.description,this.imageURL,this.category});
}
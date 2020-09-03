import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jain_namkin/model/product_item.dart';
import 'package:http/http.dart' as http;


class Products with ChangeNotifier {
  List<ProductItem> _items = [
//    ProductItem(
//      id: 'p0001',
//      imageURL:
//          'https://www.balajiwafers.com/wp-content/uploads/2019/04/T_Wafers_SimplySalted_Middle-min.png',
//      title: 'Balaji- Simply salted',
//      category: 'farsan',
//      weights: {'25g': 10, '50g': 20, '100g': 35},
//    ),
//    ProductItem(
//      id: 'p0002',
//      imageURL:
//          'https://www.balajiwafers.com/wp-content/uploads/2019/04/T_Wafers_SimplySalted_Middle-min.png',
//      title: 'Balaji- Simply salted',
//      category: 'sweet',
//      weights: {'25g': 10, '50g': 20, '100g': 35},
//    ),
//    ProductItem(
//      id: 'p0003',
//      imageURL:
//          'https://www.balajiwafers.com/wp-content/uploads/2019/04/T_Wafers_SimplySalted_Middle-min.png',
//      title: 'Balaji- Simply salted',
//      category: 'bakery',
//      weights: {'25g': 10, '50g': 20, '100g': 35},
//    ),
//    ProductItem(
//      id: 'p0004',
//      imageURL:
//          'https://www.balajiwafers.com/wp-content/uploads/2019/04/T_Wafers_SimplySalted_Middle-min.png',
//      title: 'Balaji- Simply salted',
//      category: 'farsan',
//      weights: {'25g': 10, '50g': 20, '100g': 35},
//    ),
//    ProductItem(
//      id: 'p0005',
//      imageURL:
//          'https://www.balajiwafers.com/wp-content/uploads/2019/04/T_Wafers_SimplySalted_Middle-min.png',
//      title: 'Balaji- Simply salted',
//      category: 'sweet',
//      weights: {'25g': 10, '50g': 20, '100g': 35},
//    ),
//    ProductItem(
//      id: 'p0006',
//      imageURL:
//          'https://www.balajiwafers.com/wp-content/uploads/2019/04/T_Wafers_SimplySalted_Middle-min.png',
//      title: 'Balaji- Simply salted',
//      category: 'bakery',
//      weights: {'25g': 10, '50g': 20, '100g': 35},
//    ),
//    ProductItem(
//      id: 'p0007',
//      imageURL:
//          'https://www.balajiwafers.com/wp-content/uploads/2019/04/T_Wafers_SimplySalted_Middle-min.png',
//      title: 'Balaji- Simply salted',
//      category: 'farsan',
//      weights: {'25g': 10, '50g': 20, '100g': 35},
//    ),
//    ProductItem(
//      id: 'p0008',
//      imageURL:
//          'https://www.balajiwafers.com/wp-content/uploads/2019/04/T_Wafers_SimplySalted_Middle-min.png',
//      title: 'Balaji- Simply salted',
//      category: 'sweet',
//      weights: {'25g': 10, '50g': 20, '100g': 35},
//    ),
//    ProductItem(
//      id: 'p0009',
//      imageURL:
//          'https://www.balajiwafers.com/wp-content/uploads/2019/04/T_Wafers_SimplySalted_Middle-min.png',
//      title: 'Balaji- Simply salted',
//      category: 'bakery',
//      weights: {'25g': 10, '50g': 20, '100g': 35},
//    ),
//    ProductItem(
//      id: 'p0010',
//      imageURL:
//          'https://www.balajiwafers.com/wp-content/uploads/2019/04/T_Wafers_SimplySalted_Middle-min.png',
//      title: 'Balaji- Simply salted',
//      category: 'farsan',
//      weights: {'25g': 10, '50g': 20, '100g': 35},
//    ),
  ];

  List<ProductItem> get item {
    return [..._items];
  }

  Future<void> fetchAndSetProduct() async {
    var url = 'https://project_name.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final fetchedData = json.decode(response.body) as Map<String, dynamic>;
      List<ProductItem> loadedProduct = [];
      fetchedData.forEach((productId, productData) {
        loadedProduct.add(ProductItem(
          id: productId,
          title: productData['title'],
          weights: productData['weights'],
          category: productData['category'],
          description: productData['description'],
          imageURL: productData['imagePath'],
        ));
      });
      print(response.body);
      print(loadedProduct);
      _items = loadedProduct;
    } catch (error) {
      print(error);
    }
  }


}

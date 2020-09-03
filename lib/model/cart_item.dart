class CartItem {
  final String id;
  final String title;
  final Map<String,dynamic> weights;
  final Map<String,dynamic> quantity;
  final String imagePath;

  CartItem( {this.title,this.id,this.weights,this.imagePath,this.quantity});
}
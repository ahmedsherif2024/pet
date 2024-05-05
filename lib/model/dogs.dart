class Dogs {
  String id;
  String desc;
  String title;
  String price;
  String quantity;
  String image;

  Dogs({
    this.id = '',
    required this.desc,
    required this.title,
    required this.price,
    required this.quantity,
    required this.image,
  });

  Dogs.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          desc: json['desc'] as String,
          title: json['title'] as String,
          price: json['price'] as String,
    quantity: json['quantity'] as String,
          image: json['image'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'desc': desc,
      'title': title,
      'price': price,
      'quantity': quantity,
      'image': image,
    };
  }
}

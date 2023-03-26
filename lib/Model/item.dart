class Item {
  String name;
  //stored in cents
  int price;
  int stock;
  String details;
  String imageID;
  String category;
  List<String> images;
  DateTime? dealEndDate;
  int dealPercentage;

  Item(this.name, this.price, this.details, this.imageID, this.images, this.stock, {this.dealEndDate, this.dealPercentage = 0, this.category = "N/A"});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      json['name'],
      json['price'],
      json['details'],
      json['imageID'],
      json['images'],
      json['stock'],
      dealEndDate:json['dealEndDate'],
      dealPercentage:json['dealPercentage'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "details": details,
        "imageID": imageID,
        "images" : images,
        "stock" : stock,
        "dealEndDate" : dealEndDate,
        "dealPercentage" : dealPercentage,
        "category" : category,
      };
}

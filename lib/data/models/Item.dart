class Item {
  final String title;
  final List<dynamic> choices;
  final String imageURL;
  final double price;
  final List<dynamic> choiceSelections;

  Item(
      {required this.title,
      required this.choices,
      required this.imageURL,
      required this.price,
      required this.choiceSelections});

  Map<String, dynamic> toMapDynamic() {
    Map<String, dynamic> cartMap = {
      "title": title,
      "choices": choices,
      "imageURL": imageURL,
      "price": price,
      "choiceSelection": choiceSelections,
    };

    return cartMap;
  }

  factory Item.fromMap(Map<String, dynamic> snapshot) {
    List<dynamic> choicess = snapshot["choices"];
    return Item(
        title: snapshot["title"],
        choices: snapshot["choices"],
        imageURL: snapshot["imageURL"],
        price: snapshot["price"],
        choiceSelections: snapshot["choiceSelection"]);
  }
}


void main() {
  // String
  String combine = '''  
  Hellow
  howe are you''';

  // List
  List contacts = ['Umer', 'Haseeb', 1234];
  print(contacts);

  contacts.forEach((filter) {
    print('$filter');
  });

  // Map
  Map mapofFilters = {
    'id1': 'Umer',
    'id2': 'Haseeb',
    'id3': 'Haider'
  };

  print(mapofFilters['id4']);

  mapofFilters.forEach((key, value) {
    print('$key : $value');
  });

  // Runes
  Runes myEmoji = Runes('\u{1f607}');
  print(String.fromCharCodes(myEmoji));

  //if else
  // Boolean check
  bool check = false;
  
  if (check) {
    print('Condition True');
  } else {
    print('Condition False');
  }

  //For loop
  for (var vallues in contacts) {
    print('Values: $vallues');
  }

  //Function
  void orderEspresso(int howManyCups){
    print('Cups #: $howManyCups');
  }
  orderEspresso(999);

  bool orderCoffee(int howManyCups){
    print('Cups #: $howManyCups');
    return true;
  }

  bool isDone = orderCoffee(999);
  print('Order Done: $isDone');
  

  bool isDoneOrder([int? howManyCups]){
    print('Cup# $howManyCups');
    bool order = false;
    if(howManyCups!=null)
    {
      order = true;
    }
    return true;
  }

  bool isOrderDone = isDoneOrder();
  print('Order Done: $isOrderDone');
   isOrderDone = isDoneOrder(45);
  print('Order Done: $isOrderDone');

  Fruit fruit = Fruit('Apple');
  print('${fruit.type}');
}


class Fruit {
  String type;
  Fruit(this.type);

  // Fruit({required this.type});
}

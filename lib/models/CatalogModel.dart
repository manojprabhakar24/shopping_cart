import 'package:flutter/material.dart';

class CatalogModel {
  static List<String> itemNames = [
    'Cabbage',
    'Arugula',
    'Spinach',
    'Celery',
    'Lettuce',
    'Coriander leaves',
    'Mint',
    'Spring onion',
    'Bok choy',
    'Romaine lettuce',
    'Rapini',
    'Mustard greens',
    'Kale'
  ];

  /// The catalog is infinite , looping over [itemNames].
  Item getById(int id) => Item(id, itemNames[id % itemNames.length]);

  ///Get item by its position in the catalog.
  Item getByPosition(int position) {
    /// Simplifying this case - An items position in the catalog is also its id.
    return getById(position);
  }
}

@immutable
class Item {
  final int id;
  final String name;
  final Color color;
  final int price = 42;

  Item(this.id, this.name)
  // TO the the app  look nicer , for each item is given one of the material design primary color.
      : color = Colors.primaries[id % Colors.primaries.length];

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
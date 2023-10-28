import 'package:flutter/foundation.dart';


import 'CatalogModel.dart';

class CartModel extends ChangeNotifier {
  /// THe private field backing [CatalogModel]
  late CatalogModel _catalog;

  /// Iternal, privae state of cart . stores the ids of each item
  final List<int> _itemIds = [];

  /// The current catalog used to construct items from ids.
  CatalogModel get catalog => _catalog;

  int get totalPrice => items.fold(0, (total, count) => total + count.price);

  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;
    notifyListeners();
  }

  /// List of items in the cart.
  get items => _itemIds.map((id) => _catalog.getById(id)).toList();

  void add(Item item) {
    _itemIds.add(item.id);
    notifyListeners();
  }

  void remove(Item item) {
    _itemIds.remove(item.id);
    notifyListeners();
  }
}
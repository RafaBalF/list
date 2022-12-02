import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:proj_list/models/item_model.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  ObservableList<ItemModel> listItems = [
    ItemModel(title: "Item 1", check: true),
    ItemModel(title: "Item 2", check: false),
    ItemModel(title: "Item 3", check: false)
  ].asObservable();

  @action
  addItem(ItemModel model) {
    listItems.add(model);
  }

  @action
  removeItem(ItemModel model) {
    listItems.removeWhere((item) => item.title == model.title);
  }

  @computed
  int get totalCheck => listItems.where((item) => item.check == true).length;

  @computed
  List<ItemModel> get listFiltered {
    if (filter.isEmpty) {
      return listItems;
    } else {
      return listItems
          .where(
              (item) => item.title.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    }
  }

  @observable
  String filter = '';

  @action
  setFilter(String value) => filter = value;
}

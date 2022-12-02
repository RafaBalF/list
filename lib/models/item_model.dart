// ignore_for_file: unused_element, library_private_types_in_public_api

import 'package:mobx/mobx.dart';
part 'item_model.g.dart';

class ItemModel = _ItemModelBase with _$ItemModel;

abstract class _ItemModelBase with Store {
  _ItemModelBase({this.title = '', this.check = false});

  @observable
  String title;

  @observable
  bool? check = false;

  @action
  setTitle(String value) => title = value;

  @action
  setCheck(bool? value) => check = value;
}

import 'child.dart';

class Parent extends Child {
  /*final String id;
  final List¯­ name;*/
  List<Child> children = [];
  Child? currentChild;

  Parent({required super.id, required super.name, required super.password, required this.children});
  
  void setParentAsChild(Child child) {
    currentChild = child;
  }
}
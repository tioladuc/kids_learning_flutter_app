import 'child.dart';

class Parent extends Child {
  /*final String id;
  final List¯­ name;*/
  List<Child> children = [];
  Child? currentChild;

  Parent({required super.id, required super.name, required super.login, required super.password, required this.children});
  
  void setParentAsChild(Child child) {
    currentChild = child;
  }

  static Parent copy(Parent parent) {
    List<Child> tmp = [];
    for (var element in parent.children) {
      tmp.add(Child.copy(element));
    }
    return Parent(id: parent.id, name: parent.name, login: parent.login, password: parent.password, children: tmp);
  }
}
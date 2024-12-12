import 'package:flutter/material.dart';

class MenuDar {
  String? title;
  Icon? icon;
  Widget? screen;

  MenuDar({this.title, this.icon, this.screen});

  MenuDar.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    icon = json['icon'];
    icon = json['screen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['icon'] = icon;
    data['screen'] = screen;
    return data;
  }

  @override
  toString() => "title: $title, icon: $icon, screen: $screen";
}

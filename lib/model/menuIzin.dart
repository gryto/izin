import 'package:flutter/material.dart';

class MenuIzin {
  String? title;
  Icon? icon;
  Widget? screen;
  Widget? color;

  MenuIzin({this.title, this.icon, this.screen, this.color});

  MenuIzin.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    icon = json['icon'];
    icon = json['screen'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['icon'] = icon;
    data['screen'] = screen;
    data['screen'] = color;
    return data;
  }

  @override
  toString() => "title: $title, icon: $icon, screen: $screen, color: $color";
}

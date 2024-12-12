import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;

import '../../utils/constants/colors.dart';

class UserCard extends StatelessWidget {
  final IconData icon;
  final String? title;
  final String? progress;
  final String? reason;
  final Color color;
  final Color colorbg;
  final Color colorTitle;
  final VoidCallback onClick;

  const UserCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.progress,
    required this.reason,
    required this.color,
    required this.colorbg,
    required this.colorTitle,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: const Duration(milliseconds: 130),
      onTap: onClick,
      child: Card(
        color: colorbg,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title! ?? "",
                    style: TextStyle(
                      color: colorTitle,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    reason! ?? "",
                    style: TextStyle(
                      color: colorTitle,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  badges.Badge(
                    badgeStyle: badges.BadgeStyle(
                      shape: badges.BadgeShape.square,
                      borderRadius: BorderRadius.circular(5),
                      badgeColor: ColorApp.button,
                    ),
                    position: badges.BadgePosition.custom(
                      start: 10,
                      top: 10,
                    ),
                    badgeContent: SizedBox(
                      width: 90, // Atur lebar badge sesuai kebutuhan
                      child: Text(
                        progress! ?? "",
                        maxLines: 2, // Maksimum 2 baris
                        overflow: TextOverflow
                            .ellipsis, // Tambahkan '...' jika terlalu panjang
                        textAlign: TextAlign.center, // Pusatkan teks
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

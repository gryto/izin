import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;

class ActivityCard extends StatelessWidget {
  final IconData icon;
  final String? title;
  final String? subtitle;
  final String? date;
  final String? progress;
  final String? reason;
  final Color color;
  final Color colorbg;
  final Color colorTitle;
  final VoidCallback onClick;
  final Widget popupMenuButton;

  const ActivityCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.progress,
    required this.reason,
    required this.color,
    required this.colorbg,
    required this.colorTitle,
    required this.onClick,
    required this.popupMenuButton,
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
                    date!,
                    style: TextStyle(
                      color: colorTitle,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    title!,
                    style: TextStyle(
                      color: colorTitle,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (subtitle!.isNotEmpty)
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 14,
                        color: subtitle == "Pending"
                            ? Colors.orangeAccent
                            : subtitle == "Wait Superadmin" ||
                                    subtitle == "Checked by SuperAdmin"
                                ? const Color.fromARGB(255, 61, 131, 248)
                                : subtitle == "Done"
                                    ? const Color.fromARGB(255, 12, 159, 111)
                                    : const Color.fromARGB(255, 240, 81, 82),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  Text(
                    reason!,
                    style: TextStyle(
                      color: colorTitle,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  popupMenuButton,
                  const SizedBox(
                    height: 15,
                  ),
                  badges.Badge(
                    badgeStyle: badges.BadgeStyle(
                      shape: badges.BadgeShape.square,
                      borderRadius: BorderRadius.circular(5),
                      badgeColor: progress == "Pending"
                          ? Colors.orangeAccent
                          : progress == "Approved" ||
                                  progress == "Done"
                              ?  const Color.fromARGB(255, 12, 159, 111)
                                  : const Color.fromARGB(255, 240, 81, 82),
                    ),
                    position: badges.BadgePosition.custom(
                      start: 10,
                      top: 10,
                    ),
                    badgeContent: SizedBox(
                      width: 80, // Atur lebar badge sesuai kebutuhan
                      child: Text(
                        progress!,
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
                  const SizedBox(
                    height: 25,
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

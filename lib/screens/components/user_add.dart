import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

class UserAddCard extends StatelessWidget {
  final String? title;
  final Color color;
  final Color colorbg;
  final Color colorTitle;
  final VoidCallback onClick;
  final bool isSelected; // Tambahkan ini

  UserAddCard({
    Key? key,
    required this.title,
    required this.color,
    required this.colorbg,
    required this.colorTitle,
    required this.onClick,
    required this.isSelected, // Tambahkan ini
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorbg,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title ?? "",
                  style: TextStyle(
                    color: colorTitle,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Radio<bool>(
                  value: true,
                  activeColor: ColorApp.button,
                  groupValue: isSelected,
                  onChanged: (_) {
                    onClick();
                  },
                ),
              ],
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorApp.button,
                  ),
                  onPressed: () {
                    print('Button pressed for $title');
                  },
                  child: const Text(
                    "Selected",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

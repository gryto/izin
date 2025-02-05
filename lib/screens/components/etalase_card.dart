import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'dottedline.dart';

class EtalaseCard extends StatelessWidget {
  final IconData icon;
  final String? title;
  final String? progress;
  final Color color;
  final Color colorbg;
  final Color colorTitle;
  // final VoidCallback onClick;
  final ImageProvider image;
  final String buttonText;
  final VoidCallback onClickButton;

  const EtalaseCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.progress,
    required this.color,
    required this.colorbg,
    required this.colorTitle,
    // required this.onClick,
    required this.image,
    required this.buttonText,
    required this.onClickButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    // Bounce(
    //   duration: const Duration(milliseconds: 130),
    //   onTap: onClick,
    //   child: 
      Card(
        color: colorbg,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: SizedBox(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      // Menambahkan Center widget untuk menempatkan gambar di tengah
                      child: SizedBox(
                        width: 181,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: Image(
                            image: image,
                            width: 150, // Ukuran gambar yang sesuai
                            height: 170, // Ukuran gambar yang sesuai
                            fit: BoxFit.contain, // Menyesuaikan gambar dengan ukuran
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: 160, // Memberikan lebar tetap untuk subtitle
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    title!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: colorTitle,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 30, // Atur ukuran sesuai kebutuhan
                                  height: 25,
                                  child: Stack(
                                    children: [
                                      // Dotted border
                                      Positioned.fill(
                                        child: CustomPaint(
                                          painter: DottedBorderPainter(
                                            color: const Color.fromARGB(
                                                255, 67, 128, 252),
                                            strokeWidth: 2,
                                            dashWidth: 5,
                                            dashSpace: 3,
                                            borderRadius: 5,
                                          ),
                                        ),
                                      ),
                                      // Badge content
                                      Center(
                                        child: Text(
                                          progress!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 67, 128, 252),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 67, 128, 252),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: onClickButton,
                              child:  Text(
                                buttonText,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
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
    // );
  }
}

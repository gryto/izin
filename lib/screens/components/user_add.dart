// import 'package:bounce/bounce.dart';
// import 'package:flutter/material.dart';

// import '../../utils/constants/colors.dart';

// class UserAddCard extends StatefulWidget {
//   final String? title;
//   final Color color;
//   final Color colorbg;
//   final Color colorTitle;
//   final VoidCallback onClick;
//   // String selectedOption;
//   // final int select;
//   // final VoidCallback onChanged;

//   UserAddCard({
//     Key? key,
//     required this.title,
//     required this.color,
//     required this.colorbg,
//     required this.colorTitle,
//     required this.onClick,
//     // required this.selectedOption,
//     // required this.select,
//     // required this.onChanged,
//   }) : super(key: key);
//   @override
//   State<UserAddCard> createState() => _UserAddCardState();
// }

// class _UserAddCardState extends State<UserAddCard> {
//   bool isSelected = false;

//   void _toggleSelection() {
//     setState(() {
//       isSelected = !isSelected;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Bounce(
//       duration: const Duration(milliseconds: 130),
//       onTap: widget.onClick,
//       child: Card(
//         color: widget.colorbg,
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 widget.title! ?? "",
//                 style: TextStyle(
//                   color: widget.colorTitle,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Radio<bool>(
//                 value: true,
//                 groupValue: isSelected,
//                 activeColor: ColorApp.button,
//                 onChanged: (value) {
//                   _toggleSelection();
//                 },
//               ),
//               // if (isSelected)
//               //   Padding(
//               //     padding: const EdgeInsets.only(top: 8.0),
//               //     child: ElevatedButton(
//               //       style: ElevatedButton.styleFrom(
//               //         backgroundColor: ColorApp.button,
//               //       ),
//               //       onPressed: () {
//               //         // Handle button action
//               //         print('Button pressed for ${widget.title}');
//               //       },
//               //       child: const Text("Selected",style: TextStyle(color: Colors.white),),
//               //     ),
//               //   ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/izin/izin_cubit.dart';
import '../../bloc/izin/izin_state.dart';
import '../../utils/constants/colors.dart';

// class UserAddCard extends StatelessWidget {
//   final String? title;
//   final Color color;
//   final Color colorbg;
//   final Color colorTitle;
//   final VoidCallback onClick;

//   UserAddCard({
//     Key? key,
//     required this.title,
//     required this.color,
//     required this.colorbg,
//     required this.colorTitle,
//     required this.onClick,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => IzinCubit(),
//       child: BlocBuilder<IzinCubit, IzinState>(
//         builder: (context, state) {
//           return Bounce(
//             duration: const Duration(milliseconds: 130),
//             onTap: () {
//               context.read<IzinCubit>().toggleSelectionBool();
//               onClick();
//             },
//             child: Card(
//               color: colorbg,
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           title ?? "",
//                           style: TextStyle(
//                             color: colorTitle,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Radio<bool>(
//                           value: true,
//                           activeColor: ColorApp.button,
//                           groupValue: state.isSelected,
//                           onChanged: (_) {
//                             context.read<IzinCubit>().toggleSelectionBool();
//                           },
//                         ),
//                       ],
//                     ),
//                     if (state.isSelected)
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8.0),
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: ColorApp.button,
//                           ),
//                           onPressed: () {
//                             // Handle button action
//                             print('Button pressed for $title');
//                           },
//                           child: const Text(
//                             "Selected",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

////
///
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

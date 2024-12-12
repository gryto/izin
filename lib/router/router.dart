import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hma2/screens/izin/report/report.dart';

import '../model/submissionAll.dart';
import '../screens/dar/dar_screen.dart';
import '../screens/izin/izin_screen.dart';
import '../screens/izin/submission/detailSubmission.dart';
import '../screens/izin/user/user.dart';
import '../screens/login_screen.dart';
import '../screens/mainpage_screen.dart';
import 'app_routes.dart';

GoRouter router(String initialLocation) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.HOME,
        builder: (BuildContext context, GoRouterState state) {
          return LoginScreen();
        },
        routes: <RouteBase>[
          GoRoute(
              path: Routes.MAINPAGE,
              builder: (context, state) => const MainpageScreen(),
              routes: [
                GoRoute(
                  path: Routes.DAR,
                  builder: (context, state) => const DarScreen(),
                ),
                GoRoute(
                    path: Routes.IZIN,
                    builder: (context, state) => const IzinScreen(),
                    routes: [
                      GoRoute(
                        path: Routes.ADDEDIZIN,
                        builder: (context, state) {
                          String detailIzinString = jsonEncode(state.extra);
                          SubmissionAll detailIzin = SubmissionAll.fromJson(
                              jsonDecode(detailIzinString));
                          print('ini dari router');
                          print(detailIzin.id);
                          final id = state.pathParameters['id'];
                          final name = state.pathParameters['username'];
                          final startDate = state.pathParameters['startDate'];
                          final endDate = state.pathParameters['endDate'];
                          final startTime = state.pathParameters['startTime'];
                          final endTime = state.pathParameters['endTime'];
                          final reason = state.pathParameters['reason'];
                          final description =
                              state.pathParameters['description'];
                          final read = state.pathParameters['readByAdmin'];
                          final readSuperadmin =
                              state.pathParameters['readBySuperadmin'];
                          print(reason);
                          return DetailSubmission(
                              status: "Pending",
                              actionMode: ActionMode.view,
                              id: id,
                              name: name,
                              startDate: startDate,
                              endDate: endDate,
                              startTime: startTime,
                              endTime: endTime,
                              reason: reason,
                              description: description,
                              read: read.toString(),
                              readSuperadmin: readSuperadmin.toString(),
                              role: "1");
                        },
                      ),
                    ]),
                // GoRoute(
                //   path: Routes.IZIN_USER,
                //   builder: (context, state) => const UserIzinPage(),
                // )
              ]),
        ],
      ),
    ],
  );
}

// // pemakaian BlocProvider pada route
// GoRouter(
//     initialLocation: '/profile',
//     routes: [
//       GoRoute(
//         path: '/profile',
//         builder: (context, state) {
//           return BlocProvider(
//             create: (context) => ProfileCubit()..initData(context, 'username', 'password'),
//             child: const ProfileScreen(),
//           );
//         },
//       ),
//       // Tambahkan route lain jika diperlukan
//     ],
//   );
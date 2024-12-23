import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hma2/screens/izin/report/report.dart';

import '../model/izinAll.dart';
import '../model/submissionAll.dart';
import '../model/user.dart';
import '../screens/dar/dar_screen.dart';
import '../screens/izin/activity/detailActivitySecond.dart';
import '../screens/izin/izin_screen.dart';
import '../screens/izin/submission/detailSubmission.dart';
import '../screens/izin/submission/detailSubmissionRow.dart';
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
                      path: "${Routes.SUBMISSIONIZIN}/:type",
                      builder: (context, state) {
                        String detailSubmissionIzinString = jsonEncode(state.extra);
                        SubmissionAll detailIzin = SubmissionAll.fromJson(
                            jsonDecode(detailSubmissionIzinString));
                        print('ini dari router');
                        print(detailIzin.id);

                        String detailUserString = jsonEncode(state.extra);
                        User detailUser =
                            User.fromJson(jsonDecode(detailUserString));
                        print('ini dari router user');
                        print(detailUser.username);
                        final type = state.pathParameters['type'];
                        return DetailSubmissionRow(
                          type: type!,
                          izin: detailIzin,
                          user: detailUser,
                        );
                      },
                    ),
                    GoRoute(
                      path: "${Routes.ADDEDIZIN}/:type",
                      builder: (context, state) {
                        String detailIzinString = jsonEncode(state.extra);
                        IzinAll detailIzin = IzinAll.fromJson(
                            jsonDecode(detailIzinString));
                        print('ini dari router');
                        print(detailIzin.id);

                        String detailUserString = jsonEncode(state.extra);
                        User detailUser =
                            User.fromJson(jsonDecode(detailUserString));
                        print('ini dari router user');
                        print(detailUser.username);
                        final type = state.pathParameters['type'];
                        return DetailActivityPage(
                          type: type!,
                          izin: detailIzin, 
                          // actionMode: ActionMode.view,
                          // user: detailUser,
                        );
                      },
                    ),
                  ],
                ),
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
import 'package:bigsangrup/screen/auth/forgetPassword/verify_otp_screen.dart';
import 'package:bigsangrup/screen/profile/add_bank_account.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screen/auth/forgetPassword/change_password_screen.dart';
import '../screen/auth/forgetPassword/forget_password_screen.dart';
import '../screen/auth/login/login_screen.dart';
import '../screen/auth/signup/signup_screen.dart';
import '../screen/bootom_navigation.dart/botom_navigation.dart';
import '../screen/error/error-screen.dart';
import '../screen/history/history_screen.dart';
import '../screen/home/add_slap_form.dart';
import '../screen/home/chalan_discount_form.dart';
import '../screen/home/comission_history.dart';
import '../screen/home/homeScreen.dart';
import '../screen/leader_board/leader_board_screen.dart';
import '../screen/parking/parking-payment-screen.dart';
import '../screen/parking/parking_historty.dart';
import '../screen/parking/parking_screen.dart';
import '../screen/parking/rewarded_screen.dart';
import '../screen/profile/add_vehicle.dart';
import '../screen/profile/all_bank_list_screen.dart';
import '../screen/profile/all_vehicle_list_screen.dart';
import '../screen/profile/profile_edit_form.dart';
import '../screen/profile/profile_screen.dart';
import '../screen/profile/show_web.dart';
import '../screen/profile/view_route_screen.dart';
import '../screen/splash_screen/splash_screen.dart';
import '../screen/support/add_support.dart';
import '../screen/support/quick_support_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRoute {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    onException: (_, GoRouterState state, GoRouter router) {
      print("sttate ${state.error.toString()}");
      print("router ${router}");
      router.go('/error', extra: state.uri.toString());
    },
    initialLocation: '/', //comment for implemetation
    // initialLocation: '/home',
    // errorBuilder: (context, state) => ErrorScreen(
    //   uri: "",
    // ),

    routes: [
      GoRoute(
        path: '/',
        name: "Splash Screen",
        // parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/error',
        name: "error",
        // parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) =>
            ErrorScreen(uri: state.extra as String? ?? ''),
      ),
      // GoRoute(
      //   path: '/changePassword',
      //   name: "SchangePassword",
      // parentNavigatorKey: _rootNavigatorKey,
      //   builder: (context, state) => ChangePassword(),
      // ),
      GoRoute(
        path: '/hme',
        name: "hme",
        // parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => HomeScreen(),
      ),

      GoRoute(
        path: '/signup',
        name: "Signup",
        // parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => SignupScreen(),
      ),
      GoRoute(
        path: '/login',
        name: "Login",
        // parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
          path: '/forget',
          name: "forget",
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            // Map<String, dynamic>? parameter =
            //     state.extra as Map<String, dynamic>?;
            return ForgetPassword();
          }),
      GoRoute(
        path: '/updatepas',
        name: "updatepass",
        // parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => UpdatePassword(),
      ), //
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          Map<String, dynamic>? parameter =
              state.extra as Map<String, dynamic>?;
          // print(parameter!['id']);
          // int index = 0;
          return NavigationScreen(
            child: child,
            index: int.parse(parameter?['id'] ??
                "0"), //parameter!['id'] ??  comment for implement
          );
        },
        routes: [
          GoRoute(
              path: '/home',
              name: "Home",
              // parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) {
                print('Navigating to HomeScreen');
                // Map<String, dynamic>? parameter =
                //     state.extra as Map<String, dynamic>?;
                return HomeScreen(
                    // sear: parameter!['sea'],
                    );
              },
              routes: [
                //         //LiftRequestSuccessScreen
                GoRoute(
                  path: 'addSlap',
                  name: "addSlap",
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    Map<String, dynamic>? parameter =
                        state.extra as Map<String, dynamic>?;
                    return AddSlapForm(
                      data: parameter!['slip'],
                      // details: parameter!['details'],
                    );
                  },
                ),
                GoRoute(
                  path: 'chalandiscount',
                  name: "chalandiscount",
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    Map<String, dynamic>? parameter =
                        state.extra as Map<String, dynamic>?;
                    return ChalanDiscountForm(
                      data: parameter!['slip'],
                      // details: parameter!['details'],
                    );
                  },
                ),
                
                GoRoute(
                  path: 'commision',
                  name: "commision",
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    Map<String, dynamic>? parameter =
                        state.extra as Map<String, dynamic>?;
                    return CommisionHistory();
                  },
                ),
                        GoRoute(
                          path: 'parking',
                          name: "parking",
                          parentNavigatorKey: _shellNavigatorKey,
                          builder: (context, state) => ParkingScreen(),
                        ),
                        GoRoute(
                          path: 'bookparking',
                          name: "bookparking",
                          parentNavigatorKey: _shellNavigatorKey,
                          builder: (context, state) {
                            Map<String, dynamic>? parameter =
                        state.extra as Map<String, dynamic>?;
                            return ParkingPayment(parkingData: parameter!['park'],);
                            },
                        ),
                        GoRoute(
                          path: 'recentPark',
                          name: "recentPark",
                          parentNavigatorKey: _shellNavigatorKey,
                          builder: (context, state) {
                            Map<String, dynamic>? parameter =
                        state.extra as Map<String, dynamic>?;
                            return ParkingHistorty(myParking: parameter!['myParking'],);
                            },
                        ),GoRoute(
                          path: 'parkwidget',
                          name: "parkwidget",
                          parentNavigatorKey: _shellNavigatorKey,
                          builder: (context, state) {
                        //     Map<String, dynamic>? parameter =
                        // state.extra as Map<String, dynamic>?;
                            return RewarderdScreen();
                            },
                        ),
                        GoRoute(
                          path: 'leaderboard',
                          name: "leaderboard",
                          parentNavigatorKey: _shellNavigatorKey,
                          builder: (context, state) {
                        //     Map<String, dynamic>? parameter =
                        // state.extra as Map<String, dynamic>?;
                            return LeaderBoardScreen();
                            },
                        )

                //         GoRoute(
                //             path: 'showpay',
                //             name: "showpay",
                //             parentNavigatorKey: _shellNavigatorKey,
                //             builder: (context, state) {
                //               Map<String, dynamic>? parameter =
                //                   state.extra as Map<String, dynamic>?;
                //               return ShowAlladsSealler(
                //                   name: parameter!['adsName'].toString(),
                //                   adsID: parameter!['adsID'].toString());
                //             },
                //             routes: [
                //               GoRoute(
                //                 path: 'dt',
                //                 name: "dt",
                //                 parentNavigatorKey: _shellNavigatorKey,
                //                 builder: (context, state) {
                //                   Map<String, dynamic>? parameter =
                //                       state.extra as Map<String, dynamic>?;
                //                   return SingleProductDetail(
                //                     details: parameter!["details"],
                //                   );
                //                 },
                //               ),
              ]),
          GoRoute(
              path: '/profie',
              name: "Profile",
              // parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) => ProfileScreen(),
              routes: [
                GoRoute(
                  path: 'editProfile',
                  name: "editProfile",
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    Map<String, dynamic>? parameter =
                        state.extra as Map<String, dynamic>?;
                    return EditProfile(
                        // userDetails: parameter!['user'],
                        // urll: parameter!['url'],
                        );
                  },
                ),
                GoRoute(
                  path: 'addvehicle',
                  name: "addvehicle",
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    Map<String, dynamic>? parameter =
                        state.extra as Map<String, dynamic>?;
                    return AddVehicle(
                        // userDetails: parameter!['user'],
                        vehicle: parameter!['vech'],
                        );
                  },
                ),
                  GoRoute(
                  path: 'vehicle',
                  name: "vehicle",
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    Map<String, dynamic>? parameter =
                        state.extra as Map<String, dynamic>?;
                    return AllVehicleListScreen(
                      park: parameter!['book'],
                        // userDetails: parameter!['user'],
                        // urll: parameter!['url'],
                        );
                  },
                ),
                GoRoute(
                  path: 'allbank',
                  name: "allbank",
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    // Map<String, dynamic>? parameter =
                    //     state.extra as Map<String, dynamic>?;
                    return AllBankListScreen(
                        );
                  },
                ),
                GoRoute(
                  path: 'bank',
                  name: "bank",
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    Map<String, dynamic>? parameter =
                        state.extra as Map<String, dynamic>?;
                    return AddBankAccount(
                        // userDetails: parameter!['user'],
                        // urll: parameter!['url'],
                        );
                  },
                ),
                GoRoute(
                  path: 'changePassword',
                  name: "changePassword",
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    Map<String, dynamic>? parameter =
                        state.extra as Map<String, dynamic>?;
                    return ChangePassword(
                        // userDetails: parameter!['user'],
                        // email: parameter!['deleteEmail'],
                        );
                  },
                ),
                  GoRoute(
                  path: 'web',
                  name: "web",
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    Map<String, dynamic>? parameter =
                        state.extra as Map<String, dynamic>?;
                    return ShowWeb(
                      urll: parameter!['url'],
                        // userDetails: ,
                        // email: parameter!['deleteEmail'],
                        );
                  },
                ),   GoRoute(
                  path: 'viewroute',
                  name: "viewroute",
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (context, state) {
                    Map<String, dynamic>? parameter =
                        state.extra as Map<String, dynamic>?;
                    return ViewRouteScreen(
                        // userDetails: parameter!['user'],
                        // email: parameter!['deleteEmail'],
                        );
                  },
                ),
              ]),
          GoRoute(
              path: '/history',
              name: "history",
              // parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) => HistoryScreen(),
              routes: [
                //           GoRoute(
                //             path: 'adsDetails',
                //             name: "adsDetails",
                //             parentNavigatorKey: _shellNavigatorKey,
                //             builder: (context, state) {
                //               Map<String, dynamic>? parameter =
                //                   state.extra as Map<String, dynamic>?;
                //               return myAdsDetailsScreen(
                //                 details: parameter!['myAds'],
                //               );
                //             },
                //           ),
              ]),
               GoRoute(
              path: '/supporrt',
              name: "supporrt",
              // parentNavigatorKey: _shellNavigatorKey,
              builder: (context, state) => QuickSupportScreen(),
              routes: [
                          GoRoute(
                            path: 'addsupport',
                            name: "addsupport",
                            parentNavigatorKey: _shellNavigatorKey,
                            builder: (context, state) {
                              Map<String, dynamic>? parameter =
                                  state.extra as Map<String, dynamic>?;
                              return AddSupport(
                                // details: parameter!['myAds'],
                              );
                            },
                          ),
              ]),
        ],
      )
    ],
  );
}

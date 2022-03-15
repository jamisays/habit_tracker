import 'package:flutter/material.dart';
import 'package:habit_tracker/providers/bad_habits.dart';
import 'package:habit_tracker/providers/good_habits.dart';
import 'package:habit_tracker/providers/streams.dart';
import 'package:habit_tracker/screens/bad_habits/relapse_history.dart';
import 'package:habit_tracker/screens/countdown_screen.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pp;

import 'package:habit_tracker/providers/auth.dart';
import 'package:habit_tracker/screens/add_habits/categories_screen.dart';
import 'package:habit_tracker/screens/good_habits/edit_good_habit_screen.dart';
import 'package:habit_tracker/screens/bad_habits/edit_bad_habit_screen.dart';
import 'package:habit_tracker/screens/filters_screen.dart';
import 'package:habit_tracker/screens/tabs_screen.dart';
import 'models/bad_habits/badHabit.dart';
import 'models/events/event.dart';
import 'models/events/eventSource.dart';
import 'models/good_habits/goodHabit.dart';
import 'screens/add_habits/menu_habit_details_screen.dart';
import './screens/add_habits/category_habits_screen.dart';
import 'screens/bad_habits/myBadHabitDetailScreen.dart';
import 'screens/good_habits/myGoodHabitDetailScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await pp.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(GoodHabitAdapter());
  Hive.registerAdapter(BadHabitAdapter());
  Hive.registerAdapter(EventSourceAdapter());
  Hive.registerAdapter(EventAdapter());
  runApp(MyApp());
}

// splash screen activate command:
// flutter pub run flutter_native_splash:create --path=C:\Users\Jami\AndroidStudioProjects\habit_tracker\lib\flutter_native_splash.yaml

// Disable landscape mode (rotation)
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, GoodHabits>(
          create: (ctx) => GoodHabits(),
          update: (ctx, auth, prevHabits) => GoodHabits()
            ..updateTokenAndGoodHabit(auth.token, prevHabits!.goodHabits),
        ),
        ChangeNotifierProvider.value(
          value: BadHabits(),
        ),
        ChangeNotifierProvider.value(
          value: Streams(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Habit Tracker',
          theme: ThemeData(
            // primarySwatch: Colors.blueGrey,
            // accentColor: Colors.amber,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Color.fromRGBO(28, 101, 140, 1),
              secondary: Color.fromRGBO(57, 138, 185, 1),
            ),
            canvasColor: Color.fromRGBO(238, 237, 222, 1),
            listTileTheme: ListTileThemeData(
              // Color.fromRGBO(216, 210, 203, 1),
              tileColor: Color.fromRGBO(216, 210, 203, 1),
            ),
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                  bodyText1: TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                  ),
                  bodyText2: TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                  ),
                  headline6: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  button: TextStyle(color: Colors.white),
                ),
            appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              // textTheme: ThemeData.light().textTheme.copyWith(
              //       headline6: TextStyle(
              //         fontFamily: 'OpenSans',
              //         fontSize: 20,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
            ),
          ),
          // home: auth.isAuthenticated
          //     ? TabsScreen()
          //     : FutureBuilder(
          //         future: auth.tryAutoLogin(),
          //         builder: (ctx, authResultSnapshot) =>
          //             authResultSnapshot.connectionState ==
          //                     ConnectionState.waiting
          //                 ? SplashScreen()
          //                 : AuthScreen(),
          //       ),
          home: TabsScreen(),

          routes: {
            // '/': (ctx) => TabsScreen(),
            // '/home': (ctx) => TabsScreen(),
            CategoriesScreen.routeName: (ctx) => CategoriesScreen(),
            CategoryHabitsScreen.routeName: (ctx) => CategoryHabitsScreen(),
            MenuHabitDetailsScreen.routeName: (ctx) => MenuHabitDetailsScreen(),
            MyGoodHabitDetailScreen.routeName: (ctx) =>
                MyGoodHabitDetailScreen(),
            MyBadHabitDetailScreen.routeName: (ctx) => MyBadHabitDetailScreen(),
            EditGoodHabitScreen.routeName: (ctx) => EditGoodHabitScreen(),
            EditBadHabitScreen.routeName: (ctx) => EditBadHabitScreen(),
            FilterScreen.routeName: (ctx) => FilterScreen(),
            CountDownScreen.routeName: (ctx) => CountDownScreen(),
            RelapseHistory.routeName: (ctx) => RelapseHistory(),
            // StatisticsScreen.routeName: (ctx) => StatisticsScreen(),
          },
          debugShowCheckedModeBanner: false,
          // onGenerateRoute: (settings) {
          //   print(settings.arguments);
          //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
          // },
          // onUnknownRoute: (settings) {
          //   return MaterialPageRoute(
          //     builder: (ctx) => CategoriesScreen(),
          //   );
          // },
        ),
      ),
    );
  }
}
